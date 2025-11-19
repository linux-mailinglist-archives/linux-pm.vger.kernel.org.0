Return-Path: <linux-pm+bounces-38223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09485C6F65F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B0382101
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241B26D4C3;
	Wed, 19 Nov 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia0fYuac";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3cpm2MB"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AD23C4F3
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562617; cv=none; b=kV7S+PV5sQ9fQeih1NuqCIoE7F6y7TijnrKcLk209D8s1JN4mYPbFWo8Zm/cpQUISjBZSJkGMM2KhcIpM5TpJOKDAGDnSG7qjnJ1L10LPyaPvG6xol47QJPtJe99RebSKqk9+pCk9kU+4D2Pm1DDWdMbIVPy2y+3pn8cJKnvIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562617; c=relaxed/simple;
	bh=HN9WxEdgU7MMRMzMDeKmkkf2Ro7AbX7YWoNU023BNaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+45meU2CJg8Buu0AxVP7LgtDJYDTHMj7SZbR2t3uUwnExgWOiJ2KW0s/y/M9sQiMqTd/RBiyq266E87nLHodba4gpVq6k9/KSFk7kM6J89GRJ12GF//Y5Xyjk4OhyRlfGZLfPt8H13xLR68FbyrKKOYYNZ8YRO0/0H6veqnMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia0fYuac; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3cpm2MB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763562614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DRo3GAL2l3Cg7PcPTOKH4/RpRkrlinb+o8OoHyS4YM=;
	b=ia0fYuacM9z2XKVxxR6YsYmYt5Y48TGx0PFIy9P835s1g8JDWs+v/b8dOUt0cNh1yFuxKJ
	sKk6OjQ8DA7RVmwhANXBjjdYeNWuzhvclvviKrcP9mQCleCQXb2tn9jpHTlFtj3e54ipFy
	DWqwtIyP1s07SaffWbby2HgShEpP1H4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-x6apERqEOwKzDfRfnqmGpg-1; Wed, 19 Nov 2025 09:30:13 -0500
X-MC-Unique: x6apERqEOwKzDfRfnqmGpg-1
X-Mimecast-MFC-AGG-ID: x6apERqEOwKzDfRfnqmGpg_1763562612
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779981523fso35559115e9.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763562612; x=1764167412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DRo3GAL2l3Cg7PcPTOKH4/RpRkrlinb+o8OoHyS4YM=;
        b=Q3cpm2MBZjg2PF3clf7D9oYRpqyF4MvzPhkswo5v6HR90C+GI9HwYYervBbIp0YtPo
         kU+PYXAoHo5d55OXzfYb2OaRfeB6ttsPVBvJfsRkK7AuWYsBUCu3q9xQf6d6qb4LUL2O
         kmVEwmxdAh23XlfsWpSfm7z0yC6Ls6B9YLkbYB6AZYDpsMimemJY9yeIpAYvS0GKyqbG
         MXPLFZ59WpmGxTXnJBRRyh5QF5qjMXBUjKJzFyvkDZ15IXljdo7ZTEY3BsnLwbVOaNrF
         NDKFmEgpCOm02iN57fL0/QeWDJQX4LkVxCUJM4I00JbWbSfVy/3MOLlUi/IjRjjwTgvy
         XrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562612; x=1764167412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DRo3GAL2l3Cg7PcPTOKH4/RpRkrlinb+o8OoHyS4YM=;
        b=rpibjri10lLEsvtspnPXnKKNTb9s5ci5FbiseXb0Y9X3j8hlh6mOrXEHAewwXGK9An
         GO+Zn+zyN70QomxnaGOTg+VDEvVU2MKvf7wSNAXkydqLuIqyCB1MCzx0DjY5XMj7WJ8x
         RE1z8wOFj/TvrUvlj5q8/ae319LxL5gZj7iuAw+uJokUNKy59yppLSwIJzxy4Ova8f2f
         FvsPHS17j4jCIDeNwohch/q5wCLVO89iLRyUuiT+ZbGX3Hx+v6HgJr+Eym1B5jX4fdhX
         2ZMETGsfH82FZM7+iBfz4y0I+tsSGBC41Igj8jLqgslJTFNmQOpY6T1a/o4BUH1rnEaC
         DQPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTxAK7Un2srKTHKcXGGYCOXLbKiDnymWA1ioLDAFgpRUp/d7NvFNIfpJVydeI6KHFv2MO8cI6esQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTA2Asr9f7WKmsXPaKlWMcgK1ZdQeagf3IEG9JWH/0txnTQROs
	JQL+CcEIR0qzLfxoUIv3FjqZMQg66geuAXKSe0tgkNrahst/RrEjuMEdsbcuw/wBNHmhy7dIyxM
	eNpBQ91UNY1J9oacxxLbbUoYxeSGWj3plF7Zrp7kipC0ky8oahfw98JrqX7/tCeN971Ee
X-Gm-Gg: ASbGncskU/xpU8Oe+qvyRGLxW9vSxzo9Flb9JS//dO34zVJE0BvZzD1QSBvIShDBn9O
	gXyK4F25y2adkMkKgS0vP+suZAt6aW1J1pZ62TtvCavcD9BGh6XjWlCTDSRrunbqXDbao8Ag+Qm
	Vly/8+uH3RPp/LGS1Yf+bX9UTFHIPIEYxu5aM3yg+fqG3R625W9yLMLPBvUhNA8zZMIiAsws/hG
	QL6VkBleGUKI9+3wSlQSREPmHo+LFxhES8mHnzSjy0hU7OWj0elBIiPRLNwHEp+TKjvCGnUgYD2
	Kl9/iflqFvWP3AZaTEOYK8p8U1ATAJxL+5/qBJ0/Dl/4k2Y2SRHzglBYcJxxx8h9ywVr1d9HLua
	ipCwEywypczEuZ377Lgb8sP7KRhLjFK4LPGIgX9/iRVyitifTPJZCm5JkeE+SX2iaINvi8MeKYC
	EQDe+16COyrg==
X-Received: by 2002:a05:600c:3104:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4778fea6cf6mr208703765e9.33.1763562611431;
        Wed, 19 Nov 2025 06:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEURi5B6PXrBIpULXGvKA7xrMeX+MauE6Nb4f0yafrtepq4WJ1GaGaeNvZC/g4NTIup3RbEcg==
X-Received: by 2002:a05:600c:3104:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4778fea6cf6mr208703405e9.33.1763562610922;
        Wed, 19 Nov 2025 06:30:10 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1013edcsm50606475e9.4.2025.11.19.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:30:10 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/1] HID: Add support for multiple batteries per device
Date: Wed, 19 Nov 2025 14:30:02 +0000
Message-ID: <20251119143005.1513531-1-lzampier@redhat.com>
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
 drivers/hid/hid-input-test.c |  39 +++----
 drivers/hid/hid-input.c      | 191 +++++++++++++++++++----------------
 drivers/hid/hid-magicmouse.c |  10 +-
 include/linux/hid.h          |  54 +++++++---
 6 files changed, 182 insertions(+), 126 deletions(-)

--
2.51.1


