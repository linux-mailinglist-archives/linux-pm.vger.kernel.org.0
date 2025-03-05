Return-Path: <linux-pm+bounces-23459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF55AA4F687
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 06:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CA47A4886
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 05:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203361A4F09;
	Wed,  5 Mar 2025 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aVLJOYd+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E213DDAA;
	Wed,  5 Mar 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152626; cv=none; b=iM7AY/v9qXIt4WEtOagjPxWIFfNLdNaR/+aGdqUNONDp4LQxLbtUv+RNglo9kLxbCUc5j4NPf94yfJKg2KIvNwdXGtMR0+/PFUZFpVyCBG83nnyuJl3V39OfPJ8izsEedIUeZUsXwCcWbiRnFVjN8+qzbp1DwiHCV0mAsTSsl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152626; c=relaxed/simple;
	bh=9/O6eC/4zNAuaXLevTITJSjS0IzNi+cg48P7488KcUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFZzLlgUkj14Cd/1p9b9G2c611PkaKSc4SSsAf2iH6ELnfqruzMF6aUQ9hHtgh4wObByj5xNjQ90YipmBgDKGIdwSRlqcQZpnWGvsxOg0r1RaZ94XraOtSJpHa5d3w+iGHgeSvfJAwQKqbphPXoGAoE0/SMOxxduVYiIJrk9KZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aVLJOYd+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741152617; x=1741757417; i=w_armin@gmx.de;
	bh=uG1a4CRHX27/o/TyVcRaubBbKW4uTRuiaKb+dj05CP0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aVLJOYd+YV3tPdbPUMadzpbNmp0x63Fe3NvosIOZyz+l8h9M2A8nwISx/XoJdSuK
	 BivIGyLQpm2ocVENnDp08zdwlxqe3mJk/tlHGIZJb+SqfF2AGiRdd/quM0g+sBC51
	 8TBbbDsDZCEQUHzqiE+n75sOZhPKKya7ibq21hoMCAymKCBOzCeUxMJQ5qPPcJmj/
	 kipqq1JtNsP/uZRUX3u6J2m+M1Pb+/cKUuozgI/OFE4fQP9eIEc/i/pZqc6t0oquC
	 Fp8zIrnCnnOxhndvcLlwsiUIngNNLhUgvyFJz2M5NQ5vc6E6ZxrlLqc/R1wwABiTm
	 xNiEWTThAEThr4A46g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mg6e4-1tLLSp0MU2-00aS52; Wed, 05 Mar 2025 06:30:17 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	sre@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/x86: dell-ddv: Rework battery temperature handling
Date: Wed,  5 Mar 2025 06:30:06 +0100
Message-Id: <20250305053009.378609-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WfLybaArPwXi41VeJAoFUxdH6578atxcp48rWoCYh17E/ALZeGA
 0ONWqfw5qLjDQAC6DaOjq9YANWzom/poXKrrNbFhBLrSJba4XWuUJpgsSkn87VhK/c9JKCb
 Kc9cNffZHkl1iz7qyaQG6YaV0OqsW4D4S11fdywvoB99euyZdpSGNDOFKmCNzA6vWjGtYE4
 EKjfalVg9hSo7fDLWNdaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f2myFpWQbkk=;+tToephdm4xP8+Ov+R/lRwa4twh
 Na5rkXoWI5FgNCwpT75Ur4hv6lLPYVnNaX9+4cO0OR1t7eDgGhp8Wu9eH8x4QbkrElI8Qvj91
 xokwyRF5lnkzROEMX0RBRVewCnyG58gWF/Ijw13rgdXDlt+y4NZE6zjDt2KOCLXahzZ/otm8T
 tq9maSqTQgM9Wy6ixA67zXebUY0YNxaNQYEXC1cNbGfy1NBjNZdlo5oP6vWPNcy5n5atk7xXY
 DaFASc1jYqD/h71Hc4Q07JxBoAw3OMWMtmECwBYuJ59MBd7CSN8iBXH59aq+b5PCYObMA9GnN
 AnpAg7UAFef5zIc9xsvDxleypVsS7QfFxmekfMAEqw1CNB1aCZeXPqaUBiNwZ0kEE9Qv5PE8k
 0dsM7Rkqd285h22W+3USm3uCUqfiD63phbupBN0Hm55P3KRPXP8TziPwaanmKgOqunvlPnWWx
 od33OwEn1yZqPJiTOKXYH3i+G+YaFjQB8DdaRgr9Kiv5B3NrlPjZQzyZonzjemTqR1Qape0pa
 JQgehhTyj9wW+U34ICnXXZRr0aDYT0OBB2TkW+q9mGibanT0f4wnyow1hBfKYYRhXIsTXQg6Y
 4Pc0yo3VPgbHx3+M2YdGHyfvk8U1/UZU782iCxojYti3jq3nU9Re7P1943xgFiF8m3FWUiq1l
 Azl7ny50VUr8Yt2gGvzMZp5iqyd3Ux+lKtDdsj/aoWnxr4AqRfY+psGOlxXpAPixpb8cnBRpa
 vKpHcW1HNq5B8JWqAU0hF6/MF/ZrP2p+lglEvP8zSSTZtyV1BuQkIC+tUmQRj8I0+4bPYW83S
 n37YBFm4uEGnQt67mAEu8wbrjGK129QQi03C1AW48ry+JOPuj3y4VQIyBIjk+8CQpeF0owlz8
 5f3XT3rZK2aVPO+2WX0N1VBKnkDAEj/zxxsX7gbYtgLwjaB7cBOz2CxzlEb7AC4wTLlGte6zW
 45RN86ibLBZ4AAYApHNqiokIrpGqtHwDtgsPttqjqoITwAs3+LgVvltvo4nTzf9hYMA9xyfTP
 z3jIbay1K2JoL985fbcLcOxTdEcvp+CYWcWd3D4S43muDSDKvz9vmoS84KaBB0r+vQgjSA1zJ
 QGYfGwTWOZv5otkSGqXWH6M5unBgLiQOnw3ETAwAklGniSsg6/n5oM/0t9wVLf240VLFQkwRq
 Ky1qw0CS0sQnNLM9RJxSfjRzbPrnzIlLHfSB/XAIYPg/4MiQTJf9nfdadiUeAwDDjNNusMN3S
 zgckynf2D0s/32bZ4hR8wT44CLH3WQe8bzjujhRkiay2T/HUnpD2VHyHpxaSZZZbpH7vGFfI9
 plKGV62eUBuhJ95w0feMU9wvu6jKnl+WiiftZaJjgPaJcPazcHmMFhkJH7lHqnxHSvLgFHvBr
 jzzT+cGAEawS6dijkXR1AEeMeGBR5hzILfGOViG6Rk0c8BOg3XwEoua61C

This patch series reworks the handling of the battery temperature
inside the dell-wmi-ddv driver.

The first patch fixes an issue inside the calculation formula for
the temperature value that resulted in strange temperature values
like 29.1 degrees celcius.

The second patch then simplifies the battery hook handling by using
devm_battery_hook_register().

The third patch finally makes use of the new power supply extension
mechanism to expose the battery temperature to userspace. The
power supply extension mechanism also takes care that the temperature
shows up inside the hwmon interface of the associated battery.

All patches where tested on a Dell Inspiron 3505 and appear to work.

Armin Wolf (3):
  platform/x86: dell-ddv: Fix temperature calculation
  platform/x86: dell-ddv: Use devm_battery_hook_register
  platform/x86: dell-ddv: Use the power supply extension mechanism

 drivers/platform/x86/dell/dell-wmi-ddv.c | 84 +++++++++++++-----------
 1 file changed, 46 insertions(+), 38 deletions(-)

=2D-
2.39.5


