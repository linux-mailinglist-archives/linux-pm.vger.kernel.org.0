Return-Path: <linux-pm+bounces-24844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D492A7C9B4
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54F91898BE1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF21F3FE5;
	Sat,  5 Apr 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kpKTySCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CD1E5217
	for <linux-pm@vger.kernel.org>; Sat,  5 Apr 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743864159; cv=none; b=tLu0SKa43JG1Oapf54DwUD51t2u/6RKE158+2dyeiL42SAgu5VqZFewdZ/iBbgziO44KdnWki54GDQjZjhoRvgJfJ3IL2rHVgB6u7CCyx2dMbQaRRa8UbOjrmtl2CBy78snyjyfJJT5ZoaeGGuZOakkFt7YYYdPNRhLEdCz9Js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743864159; c=relaxed/simple;
	bh=XfnEVi3ovC/zw6g3a+nScy1RtngEkEo5Aoq+dlPJPpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljRxpPjt7DfUez+YANFpaOrD4HyLdPALd+tPfRXfe1GIzeA5CN+FiDUsTXfNJtUwr4VHZvJ/eWTiyzMpDMoHsCAd8Ja7fGMjy++9Z9F82lgb3fo/CJQTcFJksBqIGSl350pXKSVXIUqNwtlnq9K7Jqh+9N4N25EV86qUhz9J4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kpKTySCR; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CE19D240027
	for <linux-pm@vger.kernel.org>; Sat,  5 Apr 2025 16:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1743864148; bh=XfnEVi3ovC/zw6g3a+nScy1RtngEkEo5Aoq+dlPJPpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Autocrypt:OpenPGP:From;
	b=kpKTySCR9tVzJeZkrRR96FmaI5z2uTfS1UgZ1LpQ3uiZDUhk5hZl1Wg7atK7sF7Py
	 t2asO+qjhckqLWTAXxzO0qKwssbnQJVHhCap2/Ttyl5qFKDRg6KUJBn1mT57NZN74A
	 U2yd4Y81VINm50wKMQoE5w5YEKYFNIWFZlwKMcZMeKWKbJuW5GTkUsl3J5sqBlokOe
	 HlMB62MvRhv1jhGOhOHSSQuYMBXt7PXHJVTolJDFbkwv334aH2+ZC//yE6KFT/KF6+
	 fWFBhnGyRrDLlxlIWTNnqZLWzpqSPXXxc6mO/SFGpd74DILF9X3KADVWBTc4IBkgvM
	 JBCaAeSLwoOlg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZVJ8s527hz9rxK;
	Sat,  5 Apr 2025 16:42:21 +0200 (CEST)
From: Alexander Reimelt <alexander.reimelt@posteo.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
 Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject:
 Re: [PATCH 07/19] arm64: dts: qcom: msm8992-lg-h815: Fix CPU node
 "enable-method" property dependencies
Date: Sat, 05 Apr 2025 14:42:21 +0000
Message-ID: <4999945.OV4Wx5bFTl@stinkpad>
In-Reply-To: <d3592f32-e29c-4b40-b045-7267795a9617@oss.qualcomm.com>
References:
 <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <470e2155-7145-44ab-9d6d-117a2d98d7f8@oss.qualcomm.com>
 <d3592f32-e29c-4b40-b045-7267795a9617@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Autocrypt: addr=alexander.reimelt@posteo.de;
  keydata=xjMEZg0fSRYJKwYBBAHaRw8BAQdAIcaNTdj3NWDe5HQPCUs6oYyQygAJWP9LCzhr+C7RwMrNG2Fs
  ZXhhbmRlci5yZWltZWx0QHBvc3Rlby5kZcKZBBMWCgBBFiEEM+Wy6sI/mP5S0zIFHqi3OKk8uRIF
  AmYNH0kCGwMFCQWjo9cFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQHqi3OKk8uRJ8ogD9
  EVg4zgfmC2SqXCgms6LETAzVX4CrAS8yMhyd7Md921cA/R8lhm9B96RYgA7MvFPFJb1T6JFY75Jg
  QLXrtIE5llwHzjgEZg0fSRIKKwYBBAGXVQEFAQEHQBGDuxZLOTvppxyM4G18fSR6xzT0xkkPOia7
  Bh6L1vAAAwEIB8J+BBgWCgAmFiEEM+Wy6sI/mP5S0zIFHqi3OKk8uRIFAmYNH0kCGwwFCQWjo9cA
  CgkQHqi3OKk8uRIa1wD8CZDdCAKXstgXY96eeSSP7MecEF5TBdmWOiVgjlEIpoEA/RnGuDaj06B1
  F51wyGAjYXSmn5qFoNHu3yXyLUkFz1ME
OpenPGP: url=https://posteo.de/keys/alexander.reimelt@posteo.de.asc

> On 4/4/25 10:30 PM, Konrad Dybcio wrote:
> > On 4/4/25 4:59 AM, Rob Herring (Arm) wrote:
> >> The "spin-table" enable-method requires "cpu-release-addr" property,
> >> so add a dummy entry. It is assumed the bootloader will fill in the
> >> correct values.
> >> 
> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> > 
> > This looks good to me without knowing any better about the specifics
> > of this device..
> > 
> > +Alexander - does the bootloader you use take care of this? Otherwise
> > we can just do what Sony devices do and stop on removing the psci node

I currently can't test this, but the bootloader (lk2nd) will set it.

Alexander



