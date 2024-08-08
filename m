Return-Path: <linux-pm+bounces-12016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87994C50C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC961F27471
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F1155C9E;
	Thu,  8 Aug 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="o5QM+14H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="lcBb/ozh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CF1552E7;
	Thu,  8 Aug 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143876; cv=none; b=hSDqtgrBDgEtPmbKdIktuSJGZXWq5zLkd8Il3ElGqDgbZc6VbxkdLi+OIxt4nls89pEfz5E+DCJehoTa49tR5xpjJvZWZA0QxIapX0xmEtcpQ9QGQHWGjaDV27ODdzScQfPUi++Tz/Rc1UfA8TL1rT8g4bo4X/P9iEsZvB2LSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143876; c=relaxed/simple;
	bh=1bA27vJfct4/ZdTpxVRfsBLIKnnki+SNEaazhbo2yhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDSMPMIp+1z8bbo0PH7eDVd7xdXtLAVBN1BR7sXA4qrDZUxH4wZS5uvdBGRNGsm6HQEdPUY9wCwWtuOEiBFZIc7/3E0h2hpFzOS2uvCRiQzzZttNos2FTQQf5vXecQeg+LnQgMfb8PICK7lOLUPGi/wrBn6nCRaCNI+XVxNQvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=o5QM+14H; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=lcBb/ozh; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Lh2rCIuCOAKI/jcrHZroMWO7ixcPv7pvY3XXpqaKsxE=;
	t=1723143873;x=1723233873; 
	b=o5QM+14HC+T1Yz3CKqp8GM3hGTuTqbClqb2m+3dsvNPgadMWyTbEaOK4yVGpDjf5KDoY2Zo94OHoH4AHnN5LbSIWBP1QqpTkv3lppGxHnnXIoOtUXCMlLnqLWxqEgNPiAO364fs6gJxcl5kR5KDw/FHy6nFRH2xw0+Jrbwy9PGg=;
Received: from [10.12.4.14] (port=38178 helo=smtp39.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sc84b-003HoA-Nw; Thu, 08 Aug 2024 21:41:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Lh2rCIuCOAKI/jcrHZroMWO7ixcPv7pvY3XXpqaKsxE=; t=1723142477; x=1723232477; 
	b=lcBb/ozhvQnxNyKWAc0gB0wTYxskwy2IegZPkrxdNd0ZAlF7iQHHh2HzLPu/xCP+1GeQcZnwk+f
	TNExxj5XzmoiQl5wfgmlAcldUlvdNuTfAJVuX4XnXtJVHBsBDGvzTmefn/+kMRy+dYzGx2CPx9b9v
	ednC7fS6lP+7LQCJMls=;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sc84H-00000001fDW-1SFc; Thu, 08 Aug 2024 21:40:58 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	ulf.hansson@linaro.org,
	andre.przywara@arm.com,
	quic_rjendra@quicinc.com,
	davidwronek@gmail.com,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	macromorgan@hotmail.com,
	linus.walleij@linaro.org,
	lpieralisi@kernel.org,
	dmitry.baryshkov@linaro.org,
	fekz115@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux@mainlining.org
Subject: [PATCH v2 00/11] Add Nothing Phone (1) support
Date: Thu,  8 Aug 2024 21:40:14 +0300
Message-ID: <20240808184048.63030-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D9DED0FED0530B211039911335079E8F258F98C4CB741FF500894C459B0CD1B91F1110687159F35D3E60E583875EFAA44420F5B5A918D162B940E011F974308A47EEACAE9851930B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AC4684DF4EC4B256EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374F960C921106F05B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8EC912D4EE6DA802E9889FB57C2C458C2F9D3DD749E073ACACC7F00164DA146DAFE8445B8C89999728AA50765F79006370277CA7F994D7EF5389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D23BF7408B3F9022F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C62B3BD3CC35DA588040F9FF01DFDA4A84AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C339F181656DDEE2D9BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE77DCDFB3399A2F72843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A518F755E76AB32F625002B1117B3ED69661806E908B557BE8C89B063BDC7FAC35823CB91A9FED034534781492E4B8EEAD9CFA8CFAC159CE19C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4C02E8E32535FC7D39FF3947B3BEBA8E52C46179E97E803AA2262EBE4A850C234A7F0923522A066E5CC6C73BB6D1AD531133C4E0BFA99FFFA8EF8C92EF10C1889D477EB5E16070675218470B7D3CD69A02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhGn8bgsfX6KPd5MztBJujd
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981C177C75469266601F7A6B01B8567BB20B320891CAC49F3D3AF1D9581B9B2D6092C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B407A8A08320DA9DA2781ED034E45463FA69D8F21B1C5167D468F3CF0E9FE49B6992E62AFD1D37EAB88DE13ADEE192EA6865D6D0E49BADA7996FD3C250F0E42A18
X-7FA49CB5: 0D63561A33F958A5C39B56C4475194AC904455D11C52D963A45029630CCC3C608941B15DA834481FA18204E546F3947CC2BF4D41862DDD6BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637FD3BE98F9706FFBF389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C31A5DD7E4D586C71135872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojnAZp9Q+n/0O5MxJJQveweQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series of patches adds support for the Nothing Phone (1), identified
as nothing,spacewar. The Nothing Phone (1) is built on the Qualcomm
Snapdragon 778G+ (SM7325-AE, also known as yupik).

SM7325 is identical to SC7280 just as SM7125 is identical to SC7180, so
SM7325 devicetree imports SC7280 devicetree as a base.

All of these patches are essential for the integration of the Nothing
Phone (1) into the kernel. The inclusion of SoC IDs is particularly
important, as I encounter crash dumps if the device tree lacks msm and
board id information.

Changes in v2:
- Add Krzysztof's R-b tag (patches no. 1, 2, 10)
- Add Dmitry's R-b tag (patches no. 3, 4, 8)
- Document SM7325 as fallback to QCM6490 (patch no. 5)
- Drop patch no. 6 from v1
- Document PN553 NFC IC as fallback to nxp-nci-i2c (patch no. 6)
- Add Krzysztof's A-b tag (patches no. 7, 9)
- Switch nl.nothing.tech/nothing.tech in commit msg (patch no. 9)
- Add fallback compatibility for NFC (patch no. 10)
- Fix interrupt type for NFC (patch no. 10)
Note: Rob's A-b tag (patch no. 5) was not added because the patch was
fixed. Please look at it again.
- Link to v1:
https://lore.kernel.org/all/20240729201843.142918-1-danila@jiaxyga.com/

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
To: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
To: David Wronek <davidwronek@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Heiko Stuebner <heiko.stuebner@cherry.de>
To: "Rafał Miłecki" <rafal@milecki.pl>
To: Chris Morgan <macromorgan@hotmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Eugene Lepshy <fekz115@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: linux@mainlining.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (9):
  dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
  soc: qcom: socinfo: Add Soc IDs for SM7325 family
  cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
  soc: qcom: pd_mapper: Add SM7325 compatible
  dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
  dt-bindings: nfc: nxp,nci: Document PN553 compatible
  dt-bindings: arm: cpus: Add qcom kryo670 compatible
  dt-bindings: vendor-prefixes: Add Nothing Technology Limited
  dt-bindings: arm: qcom: Add SM7325 Nothing Phone 1

Eugene Lepshy (2):
  arm64: dts: qcom: Add SM7325 device tree
  arm64: dts: qcom: sm7325: Add device-tree for Nothing Phone 1

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../devicetree/bindings/net/nfc/nxp,nci.yaml  |    1 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |    5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts | 1263 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7325.dtsi          |   17 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
 drivers/soc/qcom/qcom_pd_mapper.c             |    1 +
 drivers/soc/qcom/socinfo.c                    |    2 +
 include/dt-bindings/arm/qcom,ids.h            |    2 +
 12 files changed, 1302 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi

-- 
2.45.2


