Return-Path: <linux-pm+bounces-37892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09AFC54E1E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 01:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936283B4FCB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B271448D5;
	Thu, 13 Nov 2025 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KD0WepmL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hak9tl3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E53E47B
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992921; cv=none; b=Fcs7m+Rn/sPDwEtyfoZ/G7oQ+eq/nA4yEceTwKTPO4eWckGyP+ZRGxwneMxqYytYjDiq7vrQKm38/Mb4cE/HgX1p6r8JyZLpzhDExnw2OeGcyWYjZZ8NBqeh8pHo5LHPRJFWPwGIwRxuS8dRpwQc7XqOUmUY3gxC9Oex8tarro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992921; c=relaxed/simple;
	bh=Y2vNdC1fdOKu3WTqJ+2BAwZop7f2ruuqCfhWlmWdCpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8dJySESx7M4mrg33xLrA7BV64knzDkQig3Y0EX+nyeGDRjsy2GOeMJ+8s3u3DMYuxrsyhsTtfc4hghAuzQQhABokd69NMPbF4HkX0mppGSTWfyUwx2iWvNAezq1Aj3OnXTGBnu3HrNBO6XuakuuAI9GOoYRoWSHwxpSCVVpvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KD0WepmL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hak9tl3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S5ZzKSnFFTV49zcwyI0NhobHlfLAH6ZslL6z8Bt9IdY=;
	b=KD0WepmLFKx8+3vcBt3gN/TS8yxNk2OPgSWNsNlsDykR9G6XmUG+tepcaBg69jzSlwbjax
	9yfe8vi1L/Wcv0AqdEmXiMmY/LHOwwTO2hfp6gCka3cJ/UqHr4/3UKi9cnLtgxyjiORXN/
	r0EuSeoYZg81xqzQ7OS/HL0iOVCSQDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-dsb9guvpNz6Vz_SEMCln_Q-1; Wed, 12 Nov 2025 19:15:16 -0500
X-MC-Unique: dsb9guvpNz6Vz_SEMCln_Q-1
X-Mimecast-MFC-AGG-ID: dsb9guvpNz6Vz_SEMCln_Q_1762992914
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477632ce314so1135315e9.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762992914; x=1763597714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5ZzKSnFFTV49zcwyI0NhobHlfLAH6ZslL6z8Bt9IdY=;
        b=Hak9tl3HfVENXTxSUJJGKA9iOm0t4MxGxEr2zGL3CBYki92ZR+gXy/vTxeSsoUlRx6
         pui9VNjqvwJMNn6mXjD2ZyBiiY7GrXOtgGc0oQ3W+QXI1MsUvw1YGMy3HX9noFRPDC69
         lYtvGgWR7ND7Y54ZOXxXsYH+CBA19jdHzs5TnLgt6+8UXkMkEMTBfkTYrV086FrpFG9d
         VoAkpRkLe1YpyYbFNq1U/gNiu1P7fudKaNEQT6UYkLK2zNi4uBdPpSnHNR7d+/BKxTMe
         E7GfVYblThw+cq0jCPCtRpSwG7tOgvV1cFUjYm0ZC0WcRnPe/ePHzJKtbhSiEocx9zi7
         wtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992914; x=1763597714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5ZzKSnFFTV49zcwyI0NhobHlfLAH6ZslL6z8Bt9IdY=;
        b=vG/jv3DuVKuG+SexGQewTQAfO20hM6hvN6cH/X7LZanW700ToiVMcbusIa+khIFCGe
         7zZDu/+SBc5ZU1edZSV5Vo225EsW8w90mkbVYqS10F91ei5PQxkGEsKdX6X+O1/02bH3
         fiF73ip9NTQ8IBlvlgtaRvW05cLhM2lCe+4XC+JG9P6cerAozZDxfXMPBueP+wFendGn
         BHbyXq45NY1ZDssnI/ihcTxi42HBqDW0Qw4Sub/Os7JIaYD513XelExVRAjZKtr7LBtX
         LuMdmzy1A39z46/FgBGfPlcaraW4Ua0DwxaEb68dNFGCmeKOffc90sFa1JuHhqGUxzf5
         iVog==
X-Forwarded-Encrypted: i=1; AJvYcCVjb/jdhXWDRJsQUkNL/q2mg4hWH6iHpJjuWsLZ52H2XA4Mm3w/MTqRyLcYqrlJ8npcygW3KDKPDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IEGIGHDZ1Os+i/3vxvHaB1F92f9GF6Jya+5ExpcbOLQkWb3e
	TVbMxz8aGtQHr19U0R41NxOQ3LeoNPk3ZaQdXVyUJGWuBEW31sULuokxjDJevvDE/EwwKm40Y1k
	WbrEu0Iuvd2IPxlGWW3N6eBEDqbFDYgJQ1UWzyEeL5DLQMwXxUdZB1k7AInmA
X-Gm-Gg: ASbGncsDOJxODYe8oaYnRxIPdlcUAtlBytqSaUE5nVN6fFiET6kgjoegnLuqVk94l1t
	bO5PiPUpxiLPqY15/4tZB1vfdJkFn/4VOiwCgDEu8QaT9iGFAKsCdIQdErZdNF8+KW+J5FdTLZG
	FHZ2A+RKAoKvD1IWfkvQpuVQ599hyu89AIMF+piGuhixFTvrmOwNmihK66IiZl4I7uIKDFHFHa0
	gd8FRt9eTzqBGhfStGqAUwQ6HkccVWpw8L4TUoqmnMCfk3exCImqRon8D++nXXt5UfucFy8q1A3
	8N68+iXa/98EIiX6S2dSzqq9bGxsFOhhxsWgFeR8aLSxiq5M2VBfiqqjn/OHEyxSl4+UIN67JtI
	PCyvDEvNur8XIeQ==
X-Received: by 2002:a05:600c:26d1:b0:477:8985:4039 with SMTP id 5b1f17b1804b1-4778a01e47amr18495685e9.17.1762992914257;
        Wed, 12 Nov 2025 16:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsg4jnVOYbGrqvgUk0lx0gs2mkXOnVysczE7+VU6Cs7eKvrQLn4nazsZcHyX8z1XVsxBjKGA==
X-Received: by 2002:a05:600c:26d1:b0:477:8985:4039 with SMTP id 5b1f17b1804b1-4778a01e47amr18495595e9.17.1762992913810;
        Wed, 12 Nov 2025 16:15:13 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm432983f8f.23.2025.11.12.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:15:13 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 0/3] HID: Add support for multiple batteries per device
Date: Thu, 13 Nov 2025 00:15:02 +0000
Message-ID: <20251113001508.713574-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC introduces support for multiple batteries per HID device, addressing
a long-standing architectural limitation in the HID battery reporting subsystem.

## Background

The current HID implementation explicitly prevents multiple batteries per device
through an early return in hidinput_setup_battery() that enforces a single-battery
assumption. Linux treats peripheral batteries (scope=Device) differently from system
batteries, with desktop environments often displaying them separately or ignoring
them entirely. However, this design doesn't account for modern multi-battery hardware patterns.

## Problem Statement

Multiple battery scenarios that cannot be properly reported today:

1. Gaming headsets with charging docks (e.g., SteelSeries Arctis Nova Pro
   Wireless) - headset battery reported, dock battery invisible
2. Graphics tablets with stylus batteries (Wacom) - requires driver-specific
   workarounds
3. Wireless earbuds with per-earbud batteries plus charging case
4. Multi-device receivers (Logitech Unifying) - requires proprietary HID++
   protocol parsing

This forces manufacturers to use proprietary protocols and vendor-specific
software. Community projects parse USB packets directly because standard HID
battery reporting cannot handle multi-battery scenarios.

## Why This Matters

The current limitation creates a cycle: OS lacks support, so manufacturers
implement proprietary protocols, which makes vendor software necessary, which
reduces pressure to fix the OS limitation. Improving HID core support for
multiple batteries would enable standardized reporting, reduce the need for
vendor software, improve OS integration, reduce driver duplication, and provide
a foundation for future multi-battery devices.

## Proposed Solution

This series introduces struct hid_battery to encapsulate individual battery
state, refactors the code to use this structure internally, and adds support
for multiple batteries tracked in a list within struct hid_device. Batteries
are identified by report ID. The implementation maintains full backwards
compatibility with existing single-battery code.

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

## Request for Comments

Is list-based storage appropriate or would another structure work better?
Should we support usage-based identification in addition to report ID for
devices using the same report ID? Is sequential naming (battery-N) sufficient
or should batteries have semantic role identifiers like "main", "stylus", "dock"?

To HID maintainers (Jiri Kosina, Benjamin Tissoires): Does this belong in
hid-input.c or should it be separate? Any concerns about the backwards
compatibility approach? Meaning, should I have removed the whole
dev->bat legacy mapping and use the new struct?

To power supply maintainers (Sebastian Reichel): Any issues with multiple
power_supply devices from a single HID device?

Related commits:
- c6838eeef2fb: HID: hid-input: occasionally report stylus battery
- a608dc1c0639: HID: input: map battery system charging
- fd2a9b29dc9c: HID: wacom: Remove AES power_supply after inactivity

Community projects demonstrating the need:
- HeadsetControl: https://github.com/Sapd/HeadsetControl
- Solaar: https://github.com/pwr-Solaar/Solaar
- OpenRazer: https://github.com/openrazer/openrazer

Lucas Zampieri (3):
  HID: input: Introduce struct hid_battery
  HID: input: Refactor battery code to use struct hid_battery
  HID: input: Add support for multiple batteries per device

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

 drivers/hid/hid-core.c  |   4 +
 drivers/hid/hid-input.c | 196 +++++++++++++++++++++++++++-------------
 include/linux/hid.h     |  42 ++++++++-
 3 files changed, 179 insertions(+), 63 deletions(-)

--
2.51.1


