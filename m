Return-Path: <linux-pm+bounces-32930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D2B3283B
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58275E290C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81B245021;
	Sat, 23 Aug 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Q6F316HE";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="50idLLFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C840227B88;
	Sat, 23 Aug 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755945342; cv=pass; b=CIEujKPUVOVeu3ckVR9tMnfaRF/FxCmug43ubE/GEvfN3acYGD5AIzWw3VhPiz0T/Js9zohuktFBk3Q/qaZtkDxtqyt3x8U6zx7vwK7w13kb/TIZeX3sc9J12bvzk3E9aRJUXYXGbaNHkEXsF0oe0wLZMpBxG6RIL0FHGsTNSJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755945342; c=relaxed/simple;
	bh=wKrq1colAdgo7B2zfsYrVPx8HBjz3x6Ygf6pnu4x7Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9c6+QfGhDgswcJl2WaFebXGfwuu3oHcuDYe/nARdkYIU0lBl5FXgbfpkc0qBbRRvoE7jcGz5yYJISQJqQ5TtGFF4S7N+RBD6txCqo+xS0IKY9OW8cQngmL0+alqcxvcyXvKJGnB7mpx2UPgxusgnb3cSTnS/4yGn3sDOcEn1Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Q6F316HE; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=50idLLFt; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1755945305; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r75XMAFuUxqfJ1MmntrorOiU2XuBc2jFuQhFFqdre52tVm20GQ0OsX6dj+bi/48NlI
    z+MpzHylA23HSHl+jMnIyDrzWJp3i0spJNQwW8PW3Lh3TIFxz4LSexEj4Wxb+9vnqCYf
    0Wo3l/dV2S1pidgHwITHex9n0hUEUVXo7xqEC8RaU88V1A+V3O3K+re6+alPWCfU8IOB
    /Iz9tC8xvsKL38k10LTfAh//ugcaYqofaMpLeFo3VUlAGiAepiZ3C5NIZF0Zsgx+uFS/
    rdOrFr4d+KgJcYa3E9rN36G0iQofshOv2Ft757lcqqeaRvlY5MM3AriEMWnAK68S22a4
    d7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945305;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UjUFPC2gz+G8jhW1JK8yq+2DwFwwh3M2EZxQv4lyVbA=;
    b=JOgmFcq0RIH6r3/Yjgu7UkMzn3KSbx1eOsRfyP6VbBJjzQIMu9mndZ8mId5ms/ySbv
    GIheRS5u5a+4DRz5N+uLaIT4wkfI7iva2hESNZQfI4WmwTB716rfS2ozAxMs3RQH+MA7
    xugtjkrlJNuI5vtAHot7x4ogd8j3XrtgKG52H54eIbTql5rryht0QYeMLA0i3xmr9Am7
    WgJC9HncHdxw4IGoRnFPJN5NvGsXV5rm37HqcVyD+C1VnyEaLQmAX9cIWLEyFepIQk7M
    XDsL1uZ9EwvrhWCmolE8LeZFPqnb3USntg/xUebtI6rm3fPcL+EM4PRpJMrge/a9DCOL
    LOlA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755945305;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UjUFPC2gz+G8jhW1JK8yq+2DwFwwh3M2EZxQv4lyVbA=;
    b=Q6F316HEEf3+BVh+CbWZy5c1wLuo3Nr2gPPY/+TkTLsibofJ65WG5B+EXchnXJmyp8
    +7BdyzvSNukdfWhZh1TC9rHSp60KJGDyYmXga7jpkof1OEeJpGFOPzFvf3WPZZ+eec84
    k7+2FQdYE93iZBtAItziNqvWcIxtihjKyum+Y0qkxjCdwFjNAd3I9HcgN4IAryz0qblY
    /9V96riSd/zfI3oZmux1wwfKQbwWNAWMTDX4zjsrf/ElbUPCZ9hQbFK/wQTs4/fzTb09
    3iZu+9BzJ2rCQgpECAPPkHJcmhaEnRg9trB4gLKITPuA5jcIr5QLV0ibBqd9CfUu/j8M
    GbrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755945305;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UjUFPC2gz+G8jhW1JK8yq+2DwFwwh3M2EZxQv4lyVbA=;
    b=50idLLFtiM2kLcV2oRZPHWL8Gcsvnajr7MO6/gq3IBZ2IrQIT1XO9Pp5SmXzUvxEer
    JyWoIJkxviBqpxFbCVBw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ35pZnciHiRbfLxXMND9/QZnI+FEnHoj9hoo="
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id Q307a417NAZ58w6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 12:35:05 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Sebastian Reichel <sre@kernel.org>,
	Jerry Lv <Jerry.Lv@axis.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	kernel@pyra-handheld.com,
	andreas@kemnade.info,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/2] power: supply: bq27xxx: bug fixes
Date: Sat, 23 Aug 2025 12:34:55 +0200
Message-ID: <cover.1755945297.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

PATCH V2 2025-08-23 12:33:18:
Changes:
* improved commit description of main fix
* new patch: adds a restriction of historical no-battery-detection logic to the bq27000 chip

PATCH V1 2025-07-21 14:46:09:


H. Nikolaus Schaller (2):
  power: supply: bq27xxx: fix error return in case of no bq27000 hdq
    battery
  power: supply: bq27xxx: restrict no-battery detection to bq27000

 drivers/power/supply/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.50.1


