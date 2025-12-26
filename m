Return-Path: <linux-pm+bounces-39945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0EBCDE9FC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 12:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E400F3012BD9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4F31A801;
	Fri, 26 Dec 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ8LwPuP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+oYWbRs"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFF31960F
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747432; cv=none; b=b5nk6MQjQjwtIqeaDxa5ODsrxYQfwdLJl+wOFazfD2Uu9JwiknJUmMdRP0JCIA6KRrwJ5lbsNd+/0QerHgm/h6ZZ1OPSjyYmGDTLT9NSl+fxcYhHGNjlmVLLXD7V0bP5chflHfvb3HmWC+khM0jTgUPj0Rw/eD4W+FjjdkN3Fzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747432; c=relaxed/simple;
	bh=6XVhJABznxJQSZ7CcQDSziZAdWLkzwy2q7pCqs6tCDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1LGwRzpjfzzap2eICOl7mNsg7BD+dMElLGQCLS4Cy3OytJeaodzLmKDgO17fqY3uAYQ0usZ7kvffNbuOAkUTsUGJ4sK46pS6jOCZ4i5yWTAKpvq8kE95hcvQFO2xeiNbJRvUqNfTZs3N/Fc2AS75AMnJJjB4G+RiwQyccPgOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ8LwPuP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+oYWbRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766747429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X6RnF9oXZ3RxKDu+LPwnnX4t+k9ddbAsuLiaDjD4wUs=;
	b=BZ8LwPuPt8rKWXcp56CNnD9TOda43j80rMv6KMaCfQVgAAaxjtuarB3h+aUXn/Qrby3jar
	kfyASUlIScn3nsbIH6lHLBMtwR3FBJ8eqUW1Gx9fgZiR2EtyS15Rr7zZZj0xBV2oOdeaFa
	0eZlUEKK3odS7itW3iW732pnOB+bn60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-If08Oj8fOrCXy90-qVX_KQ-1; Fri, 26 Dec 2025 06:10:26 -0500
X-MC-Unique: If08Oj8fOrCXy90-qVX_KQ-1
X-Mimecast-MFC-AGG-ID: If08Oj8fOrCXy90-qVX_KQ_1766747426
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d17fff653so24774805e9.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766747426; x=1767352226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6RnF9oXZ3RxKDu+LPwnnX4t+k9ddbAsuLiaDjD4wUs=;
        b=V+oYWbRsVYlpE2w3A4eGVhcWeq6gxPT8KVIGinFIOWkMnq6BJ5fy0UT9nNU52NbaiM
         grlVsbiRaa4QSw2yJUZM3CaFVO/YGyJBFGXwR2hdRxK5G10feQjRUZjJ+JsAzkDeL2X+
         MH5Q5YX6xQ4XLHTGOYl+wru8156ITP4YsGlyVanPtXqYNbiHUv8+UIwjqdv8ahk5NIyt
         26ShW1Bmwxa422vHWeZdEwQ2e6ZIcP5pnIriPutsOK9TQGgtCpAjW5BFRKlXry1/Vqfv
         8/rlnfkGIeqR52FPn3o1W5yok4o5eleZ+KPcurzsRi9XiayJTJStOcTqpuhMTI9Xqt8i
         SeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747426; x=1767352226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6RnF9oXZ3RxKDu+LPwnnX4t+k9ddbAsuLiaDjD4wUs=;
        b=ctPutzCtWGT5Y7SLXo0EhroN7SLsvnBCJtr2/HSY42T8q+5yKLt06U5Q+rQDU5mWNi
         Esp7oAsLLxRqWNuhG66qp0cBt7BvhgUki8LyBwVhzONyBcg0E2qX3yRSZgMs8+RBFquC
         KsgSzaRaGv9I1TSmcygFpcGP18iDhPqFkSlosyxVq+r/3o0XNfDAl+lu3nDFdd9PpkJ7
         xvGeySxROOqEdRlu4IeafQpw3/Ql83cytRTY40EVjIokGo+z4uR8EDpz5ylOeHUzYUM0
         KgmOyxPO+Gb0RgU21n3XKQryRDi1cJ8L7FshEI3KwlA2H4zOjVQYjyx6gDIoGiexE3Ba
         FJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUFQtRkjAaX+RuhU08haZxObWvoWux0jzqliy0eDvqV9Iq/TiaX+jdJ1ioJuGcYqqF41POiXuRoSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydz9RPDtZnkZpunGQNpnypvg29AiuIW8BzT2tW/j8oMFP6wTbp
	ec2P9MFKwUNcSwqg7lD1Ezdm1tmrVcYxBFJaBUd3rtcOPbSClvq47zIrfmCxs1bM9CG9+6DRlo8
	ldA1kiPnILndLr7D73aIQAxLV1sU6PEH0NiXFCFk1n4P7uKDmHsH00XgHuJEW
X-Gm-Gg: AY/fxX6hPKMapYl7pjgZb14pbIoMA/2AlzF4ElXOOibvhiMn+WUy0vs4cKntf9X0ia/
	UedppXALUesDmNc8ZCjA/sJnw0vl0WPYKWIv+Ai7JEPDAeGwUy3p17NyVzd4zaTkz4xHdKv/2LT
	cQzZSEKbWHJjQDeGsVgG3o0ovWEaRoOgRnI5y1ArefWteQ/KUKqam3gb2P7aIluwT9azB5bFdDL
	jzCqewNKvqYohV5kaaGClEy/V1Kr/6T4iYdgPDe6gjWOlTFPy05/bUHQTsmHu2oNzRjqy24tGQ0
	2cdDCyjJhCgJhJjIsJZmtXejbzNOMgUjHSreA0EUOt8TftRfpEMD/pZPAgSr3iDS+pUmTzw2UY6
	aYTpAowb1AJfGuxZ85f9SvR0P2wZUlIDk/FxhBO5ResQg6toWeNugpQkRQubDk9kzcDS2lcR/8q
	juOUU1y+pNSA==
X-Received: by 2002:a05:600c:6096:b0:479:3a88:de5f with SMTP id 5b1f17b1804b1-47d1959d6eemr243492355e9.36.1766747425545;
        Fri, 26 Dec 2025 03:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw/Viw1qNAAohz+Q4lRt/1eKBqqQr8oiemTzb1GECKUUagT6XSHCs8mpLNjRt0HcsLSTZh1g==
X-Received: by 2002:a05:600c:6096:b0:479:3a88:de5f with SMTP id 5b1f17b1804b1-47d1959d6eemr243491995e9.36.1766747425070;
        Fri, 26 Dec 2025 03:10:25 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm375653855e9.13.2025.12.26.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:10:24 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org,
	lcasmz54@gmail.com
Subject: [PATCH v6 0/3] HID: Add support for multiple batteries per device
Date: Fri, 26 Dec 2025 11:10:13 +0000
Message-ID: <20251226111019.31243-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.52.0
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

Lucas Zampieri (3):
  HID: input: Convert battery code to devm_*
  HID: input: Introduce struct hid_battery and refactor battery code
  HID: input: Add support for multiple batteries per device

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>

Changes in v6:
- Split v5 patch 2/2 into two separate patches as suggested by Benjamin:
  - Patch 2/3: Introduce struct hid_battery and convert existing code
    (no functional change for single-battery devices)
  - Patch 3/3: Add multi-battery list support
- Renamed hid_get_first_battery() to hid_get_battery() as suggested by
  Benjamin
- Added devm_kfree() calls in error path of hidinput_setup_battery() for
  proper cleanup if devm_power_supply_register() fails

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
 drivers/hid/hid-input-test.c |  39 ++++----
 drivers/hid/hid-input.c      | 189 ++++++++++++++++++-----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  54 +++++++---
 6 files changed, 180 insertions(+), 126 deletions(-)


base-commit: 8b690556d8fe0ee15151cc37ec49c5bbfe41d5b1
--
2.52.0


