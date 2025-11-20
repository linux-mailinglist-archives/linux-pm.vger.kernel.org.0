Return-Path: <linux-pm+bounces-38294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B680AC7394D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2F553595A4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFCE32D7DE;
	Thu, 20 Nov 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+xHrebc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n1Fx5w9B"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBE32FA26
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636113; cv=none; b=PtP9fYugQwRBh7D/creKz6WF9OFA4Kxnf1OpdqpQzLrBHBM6cJQ+/l4odt6Lz6wZHAYZ7hyH3LKJH+i4gYMYR+DDh0NpNYkWk/HokahjcQXzITC1HRkQCGQ4V9t5E0KMJQtWR7/AVJ1oaLiPCradb8jJqmAHUWBwzptFTCJV0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636113; c=relaxed/simple;
	bh=fdTVQGLc+cow9CihJGh/wotiz2R70DYSEcKQgAa4kTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRNHBDg5PiL1otwxV3Lh8r9KVRzuph3WgcWnpwpq8Hmbxu73oyeAJK9KvVS9hGAswtmdnnHNvjCDiGWxpvCZIRkvsL87KeL3GkdL7EVaydP9qYt4J5cuWIkUjjpgrLZvLpA8bgWxyOQ199e/e3obf9zvSCvepBx4m+jMuK6aiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+xHrebc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n1Fx5w9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763636110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIehiDrNGkkZ06kT+cUGnm015h0IlinjcUbP3NML4m4=;
	b=O+xHrebcQjhYh2/cOL3HxXZfux0RdfwkCqHW2l6DahoQmYNWuzh9zxeyoq1K2F1uj+vGuv
	mu+Zsl/tcUoVjVc8TCTyIe893Hhqq+xdjUHSiiRhplMahCfleMoCKie+rNFyyq0282o6J8
	zKy1mRPvo9syC7Nkv7wV9tfJ56OqbYs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-aR9kEVPCPOOzzOaq_fVpxg-1; Thu, 20 Nov 2025 05:54:47 -0500
X-MC-Unique: aR9kEVPCPOOzzOaq_fVpxg-1
X-Mimecast-MFC-AGG-ID: aR9kEVPCPOOzzOaq_fVpxg_1763636086
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5943838a6a3so465363e87.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 02:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763636086; x=1764240886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIehiDrNGkkZ06kT+cUGnm015h0IlinjcUbP3NML4m4=;
        b=n1Fx5w9B+AImogO7Q2FHz0MHikIu03g0s0gmrP3cF2meepOTLNeXrpkuKE3rvXqTsm
         Ko2lTmLQGL5rZSM260vzh43QNxpu6Qj2MH+bQZnc4EnvwH8d0p1AjVe+vC2yPs04Gj3U
         lII1wBeeEnoHfK7cs5Q7G/Bld0OTBcvqhPhXC5SuR9tc0b3v6AvC1+4hDWwGfvgcxehp
         ibcKlWkLeIkcGUifH6gubMRI1M//+I2e/azt8kg+pbBiL1NoGqmRIWdxoPHmRmQANlir
         AuMZRmGvBxdOH49Vza5DTYTNTGfDF/BA0XnYt8p89pYWKsk6qlU8A73dJsbVwBxOUU5d
         Jvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636086; x=1764240886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIehiDrNGkkZ06kT+cUGnm015h0IlinjcUbP3NML4m4=;
        b=j/QS5m1XkEpqy3TtfJtz8aX6U5Z00zcI0uLh4yJkQTUN0t0/HilY1CFI1KDSmJoSMS
         T+c4OZBYFtSUU8hXNUe9U4+rg8hXpeFSe0SOrHB21wWrvhgon5mbhneu+DOujAVaBTL3
         XGhsauhWe6Qq+f6IYO2dd4/5BEkY3RDRYrh4h6KSc37Lk67PAHSy9QKSXRUrM2H0IXb2
         7lSBHYyynGaCHGyjVhQGqAwGQ3KH7ojAr5udhZbVRAspI3oGn3ZoELe1NsSuiDjFOW+d
         Iwmmgtxeny5uEr7MmXd829bzCnxrhj+aocZMixdq/9ct1+cdPA7FKEBfvw87+SLJSpj0
         Y11Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo8FxWBqN1Zd0YkZW9OLqqEmkn7E00/sSiIdtCf/LFfZ1mapwtvKBZatOd4udIKZW41PMabZhgtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYk/r5Myh2ecDNTU9WSqAgpVwvUSeVgiJKOukMIl2Yf3h9GOh
	RkzQnwT8FNJE4YdtrJJaOy0RADJqyIR7+H3x9TshnHa4KMFwFQ0G/0BgZLjOaJPGsdDhKkv5rL1
	8VgOGLoJS0URALGhUdmd6KpVQGDJjQeBxczepnnzU1jkD6TH4J9LsnT/Ch1OYdv17DIzs
X-Gm-Gg: ASbGncs48X0fDMUBTn3BdRZTL+d1Wi2jbMjM8n3GzobopQBPB44cfSdXpGIyciXPGnA
	BJDoLCgOL1bHcZkXRoPDDQ76t76cZb8w6B8JFNqYrOd71LfbVpBkAgfMd5ti6tmr8vEcmOVHaWO
	8CtYoDpEgNdqZk8jj6j+eo+ULlKAhIi1hmypn0glx4QArZbzM/28vAn9l+FzNhQ0QnDxnvx/O2h
	zBXcN0m0hTcWliA209rKTXbT16nKHTHUsBFxFFN8t7+dZh4wOW3yLSAfTInDvJ9a4v1MWkyXW81
	jYIJEB8zJsYJojfyt5miexXkqCUXDCg7s9xlg1MNNdlJhX5libHlmxMvVHQ3g5JTIF4I+vqLXJg
	LMzoKWn48tG4cLx1RI3ZchUgaL1PSddVMeMpwFKotbAP8uc2CX8V6kpdUyUs4oIhbLViZJMYcl8
	6Vxw2BCVY=
X-Received: by 2002:a05:6512:68f:b0:595:9d90:5dc8 with SMTP id 2adb3069b0e04-5969e327c18mr844826e87.49.1763636085821;
        Thu, 20 Nov 2025 02:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6PKZ/bmOk5ANU7D0YAMfciYDBFzN1/1j3WbPaFTEv1TVjSa/sX40erTY5hJ2gSBAt3tFwKg==
X-Received: by 2002:a05:6512:68f:b0:595:9d90:5dc8 with SMTP id 2adb3069b0e04-5969e327c18mr844808e87.49.1763636085299;
        Thu, 20 Nov 2025 02:54:45 -0800 (PST)
Received: from sissix.redhat.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbefb8sm578218e87.46.2025.11.20.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 02:54:44 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/1] HID: Add support for multiple batteries per device
Date: Thu, 20 Nov 2025 10:54:38 +0000
Message-ID: <20251120105442.150508-1-lzampier@redhat.com>
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
are identified by report ID. The implementation is fully backwards compatible
with single-battery devices through a helper function.

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

Lucas Zampieri (1):
  HID: input: Add support for multiple batteries per device

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>

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
 drivers/hid/hid-input.c      | 196 +++++++++++++++++++----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  54 +++++++---
 6 files changed, 187 insertions(+), 126 deletions(-)


base-commit: 0678f5630429a5049d7663703b897e1bf8d13cd1
-- 
2.51.0


