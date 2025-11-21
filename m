Return-Path: <linux-pm+bounces-38369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C3C7929E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0623A2965F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921E2F6577;
	Fri, 21 Nov 2025 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2mnXgYP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOjVWi4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237C275B18
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730966; cv=none; b=SvBXw2KEFjUprQYjzJso83FqyMPqPV37l7Ui6SsDPYxy+nwntgrYvIvrBvFan4wFTPViNHdiaFJLUiFfQRstPg5Hk5t1OYNhRUFvRfqjd4I6RvGZn4Sb7XtBysf9O7sy4TmxnHdq/K34HISUPQb+nwvUdn+jwMaWcX9PzapOo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730966; c=relaxed/simple;
	bh=/BkkE594fUsCyhqJeALSYkKt+a5AF64RFZhX/SXHyvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qz3o7j8G1XbXBkSZcM7wt65ywxqZjfOLUYmEQj1M1G4qZBPz7BhJ/xNxqjB+KZKYLV9x0+dlYQwVLIDwtS8M51GiafwEfdcrhQqO9NbyK7mqDNmcDGqFRlZhLbaG+Mj9KsOUFAH6fgiyTmQFUiyQU1Egebgs5UP2/FfRvHqjktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2mnXgYP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOjVWi4p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763730962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NoV13vPmiMrtALSrh3dg+PL4CWMVhykeafbLwPzqoD0=;
	b=Y2mnXgYPBsBnaUid6m0j+Wz8e9pTAEWVI0tCDAKJVApS8IZLNf36C+9huWdRZ+aWkGj63B
	iq8QLi18kFqLbHArLsTD6DwDRtprRafT7AYvzw/dXKpADLZbhg+lfJaFOZPukIXcn7FkKR
	X1UQogFjxnsTvDgpCFD7SbshVC0wGxU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-V7RKDT1dNLqYzCEzJjcJ4w-1; Fri, 21 Nov 2025 08:16:01 -0500
X-MC-Unique: V7RKDT1dNLqYzCEzJjcJ4w-1
X-Mimecast-MFC-AGG-ID: V7RKDT1dNLqYzCEzJjcJ4w_1763730960
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so14324275e9.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763730960; x=1764335760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoV13vPmiMrtALSrh3dg+PL4CWMVhykeafbLwPzqoD0=;
        b=DOjVWi4pQSZkXU2Njk+zw7fr2ZMF6KAwtFZcEB/cd/1U4hipCEo5GfmygP1bwQq41A
         bvi2JRq8CtFq3Su5WZUabKDYTnvacyVoLyLX2m5BBETfRWOOc7+SwPPKsIb07zKXQFM8
         y6F7gKjjLOc5XNltkOc8IvFrSp78vO79Al33dMX62Bww8NUJU9RuuGcu1JZGJ+6Uva/Z
         fHn4z+EauiWf+u9Q33GeDaFRvSYe1JVEfTdfoF3xlw5/em4uyBFxQ7y34Qps8npu6429
         5FTrMGgCjaboGY4u6AeCSJA+1qOn+CDsuQXVBuuYDZAB/rmPswaOBnEbU+Tn2yXXzB/5
         f7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730960; x=1764335760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoV13vPmiMrtALSrh3dg+PL4CWMVhykeafbLwPzqoD0=;
        b=neqXldxHkaRjX/3s78L9txd1sW/V5XAUYCLiOwWw3QB1eqP3hspD/kXVOHxqLKCSxX
         F37KPUhsRhrzngj94f1KY0Y7SwpVMoFcQ95QPeeW/pS+2dgLnX2wDohhzOISxg7bzwmN
         hFp4lMY6+eVYf/nxnIQLBzEqCO5QaWGhKnbP1jNYDfhoS2cCI4BWZW+9MAWXEntP6hHY
         GYK1yG/QTtJ/4PV1h1QBHXfDuMelrmXcRkihPgp6PmDnDLNwEStn3aPe/iC0bMccwBxr
         C4Yv7xASGIvk5pbxlPoudBLDtebxvItJShk7TDrW5j/e0CPADLC+u9JpAGv6W6A8kM/t
         Ie6g==
X-Forwarded-Encrypted: i=1; AJvYcCW/2U20+gDRnWTKRvUBcCrnXkEV63CEk0CDglkOeKbiLvMxymiu4JNmYFpzDV3qq67xjBqayepM9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1CQwQIZig0RItTYBIiNPvUOoqqgU2thCu8lGodfJPcix/48L
	IGfQ5Pawex3i7LvavlseyGeC5/ZrvSDNrZzEw05dpRTJrEcP1IA60ViawXX99XTJbJVFSrqNZn3
	IaJKYVnYiY7rbcT5l0mUtC5lnCujzIzfWIiJUxxepwRRinsWOGq3QFEd3BdIP
X-Gm-Gg: ASbGncu0y1wW0hmtJFist5RChP+Cs916WIVwMMIkocUE11W7a3azWxTSdXXGvPKbWrS
	7lcSkfnSsVCvE0M2zpJP81pGEnMmZzlGqnWAeIW1WR09LEqCs8EYtwiDBzk+9RsYMorbWvy/dbS
	GjsngmRX0S8J7rK4T1wx/45W4lJZp9ez6Jld2aDdbfYDPUJBs55rhGSPdlMQyMP1p1ejZ63OqW0
	oNFqvhawEJCDAq5HeQ4gEWb2d4d+BTp/TYtW3+st5WxdDp+PEiu9vvSP26fJSwygnIsJjsnJY/d
	ETAU7U9oXkecYVYe0XCquV88gpaX6P1Kouc2742x/1zgnkFzSKIjIe8DUE/y3U/7qYNrl6QTeC3
	UyOj5ovcaXrLsMuJFRgdEzANuVctLhLqvQGe5pcOe4Waj70O/eiRjTdWPtB5OvdKmCmbsS6AUhW
	FR/JK2AnA=
X-Received: by 2002:a05:600c:524d:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-477c01d44b4mr23366195e9.19.1763730959817;
        Fri, 21 Nov 2025 05:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH38SwZ2eHrnA/qn6RywfYYxZgssOuXSgUXr55RXUG+E7Ys6uTWIB70tz3uWlfOu0NYvDj5qA==
X-Received: by 2002:a05:600c:524d:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-477c01d44b4mr23365825e9.19.1763730959338;
        Fri, 21 Nov 2025 05:15:59 -0800 (PST)
Received: from sissix.redhat.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3ba1b4sm43077435e9.15.2025.11.21.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:15:59 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 0/2] HID: Add support for multiple batteries per device
Date: Fri, 21 Nov 2025 13:15:52 +0000
Message-ID: <20251121131556.601130-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for HID devices with multiple batteries.

Currently, the HID battery reporting subsystem only supports one battery per
device. There are several devices with multiple batteries that would benefit
from this support:
- Gaming headsets with batteries in both the headset and charging dock
- Wireless earbuds with per-earbud batteries plus charging case
- Split keyboards with per-side batteries

## Proposed Solution

This series introduces struct hid_battery to encapsulate individual battery
state, replaces the old battery fields with a list-based approach, and adds
support for multiple batteries tracked within struct hid_device. Batteries
are identified by report ID and named as hid-{uniq}-battery-{id}. The
implementation is fully backwards compatible with single-battery devices
through a helper function. The series first converts the battery code to
devm_* as preparatory cleanup, which simplifies the subsequent refactoring
and reduces risk of memory management bugs.

## Testing

Tested with split keyboard hardware (Dactyl 5x6) using custom ZMK firmware
that implements per-side HID battery reporting. Each battery (left and right
keyboard halves) reports independently through the power supply interface with
distinct report IDs (0x05 and 0x06).

Test firmware available on my personal fork at:
https://github.com/zampierilucas/zmk/tree/feat/individual-hid-battery-reporting
If this series gets merged, these changes will be proposed to upstream ZMK.

HID descriptor and recording captured with hid-recorder:

D: 0
R: 162 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 05 07 75 08 95 01 81 03 05 07 15 00 25 01 19 00 29 67 75 01 95 68 81 02 c0 05 0c 09 01 a1 01 85 02 05 0c 15 00 26 ff 0f 19 00 2a ff 0f 75 10 95 06 81 00 c0 05 84 09 05 a1 01 05 85 85 05 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0 05 84 09 05 a1 01 05 85 85 06 09 44 15 00 25 01 35 00 45 01 75 08 95 01 81 02 09 65 15 00 25 64 35 00 45 64 75 08 95 01 81 02 c0
N: ZMK Project Dactyl 5x6
P: usb-0000:2d:00.3-4.2/input2
I: 3 1d50 615e
D: 0
E: 0.000000 3 05 00 56
E: 0.000977 3 05 00 56
E: 1.490974 3 06 00 52
E: 1.491958 3 06 00 52
E: 6.492979 3 06 00 53
E: 6.493962 3 06 00 53

The recording shows both batteries reporting with different charge levels
(Report ID 05: 86%, Report ID 06: 82%-83%), demonstrating the multi-battery
functionality. This can be used to verify UPower compatibility.

## Future Work: Userspace Integration

As suggested by Bastien, semantic battery differentiation (e.g., "left
earbud" vs "right earbud") requires userspace coordination, as HID
reports typically lack role metadata.

This will require:
1. systemd/hwdb entries for device-specific battery role mappings
2. UPower updates to enumerate and group multi-battery devices
3. Desktop environment changes to display batteries with meaningful labels

This kernel infrastructure is a prerequisite for that userspace work.

Lucas Zampieri (2):
  HID: input: Convert battery code to devm_*
  HID: Refactor battery code to use struct hid_battery and add
    multi-battery support

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>

Changes in v5:
- Split the monolithic v4 patch into two logical patches as suggested by
  Benjamin, devm_* conversion, then struct refactor and multi-battery support
  combined

Changes in v4:
- Added missing hidinput_update_battery() stub in #else block for
  CONFIG_HID_BATTERY_STRENGTH=n builds
- Reported-by: kernel test robot <lkp@intel.com>
- Closes: https://lore.kernel.org/oe-kbuild-all/202511201624.yUv4VtBv-lkp@intel.com/

Changes in v3:
- Squashed the three v2 patches into a single patch as suggested by
  Benjamin
- Removed all legacy dev->battery_* fields, using list-based storage only
- Changed battery naming to include report ID: hid-{uniq}-battery-{report_id}
- Converted battery memory management to devm_* for automatic cleanup
- Updated hidinput_update_battery() to take struct hid_battery directly
- Added hid_get_first_battery() helper for external driver compatibility
- Updated hid-apple.c and hid-magicmouse.c to use new battery API
- Simplified cover letter based on feedback

Changes in v2:
- Split the monolithic v1 patch into three logical patches for easier review:
  1. Introduce struct hid_battery (pure structure addition)
  2. Refactor existing code to use the new structure (internal changes)
  3. Add multi-battery support (new functionality)
- Added detailed testing section with hardware specifics
- Added hid-recorder output (dactyl-hid-recording.txt) demonstrating two-battery
  HID descriptor for UPower validation
- Added "Future Work: Userspace Integration" section addressing Bastien's feedback
  about semantic battery differentiation
- Added hardware examples with product links to commit messages (per Bastien's
  suggestion)
- No functional changes from v1, only improved patch organization and documentation

 drivers/hid/hid-apple.c      |  10 +-
 drivers/hid/hid-core.c       |   4 +
 drivers/hid/hid-input-test.c |  39 ++++---
 drivers/hid/hid-input.c      | 196 ++++++++++++++++++-----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  54 +++++++---
 6 files changed, 180 insertions(+), 133 deletions(-)


base-commit: 8b690556d8fe0ee15151cc37ec49c5bbfe41d5b1
--
2.51.1


