Return-Path: <linux-pm+bounces-11589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15793FF27
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D88283B76
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F018FC82;
	Mon, 29 Jul 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="KbEb8r3D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="UCPjXga2"
X-Original-To: linux-pm@vger.kernel.org
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220818F2C9;
	Mon, 29 Jul 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284379; cv=none; b=AP6FJB3FWOtZYsv7ZETdos3wfp3ifaXS/kc11rG7yRf69WtQhlebCTsCDnvLnKjPKiIBbaK4xDv5c76rVdjCxYf4h6IOlaQrfJYyyOk+TXFdCJWyFxbsY9hyETdVg92+q8Ch7QkHmqu4eRhl4Vv6HXv6CFqdv+yzwn/KxTDzy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284379; c=relaxed/simple;
	bh=JuxkhGo+6i+iGlorl/cy0LN+tmPfArJS8baFYb4WxE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LeqjomFaE6f/DA57cjTBshzDTx8vWvvoN1kia9HzWQhW7GgFseZvmzQdiuvnmwJiJSadZZlBletIdByhPNkBOlkt4tonPjlk18DdtTmfFCDPj/yYgh3+tQbynUhzAAZG3vH7dWCHUtSuq+FNZZ4A2A4wBC7JuqNNq8NgQhQGKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=KbEb8r3D; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=UCPjXga2; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=x06RUocVILuU4BpbXLAR6eGwbntwzZ/8jlZgy8GJdOk=;
	t=1722284377;x=1722374377; 
	b=KbEb8r3DzzfvRXkMhlt62ZE65+33dQIIZjdm3LiiZLlMagettrr7xQyVR1t+uYv5s9sACqVQWuxBN2xWUVahRnLGWtjHgzcQaAo+vPA3oV/MorrwW9VtHhbLfPmw808CiY9HbD/Qe+5vW0S/orhV8hW1/w1sKYdXauW8Z8WN3fw=;
Received: from [10.12.4.10] (port=53210 helo=smtp34.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1sYWq8-000ajd-MR; Mon, 29 Jul 2024 23:19:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=x06RUocVILuU4BpbXLAR6eGwbntwzZ/8jlZgy8GJdOk=; t=1722284368; x=1722374368; 
	b=UCPjXga28mFvzJk9ZAtMnlaA7FtNiReLAvOCg7U4CuoYc19a6v9rLyFMwoQV50MTzgimx3vfoPx
	1+FN5+HEEMttAsF00fBurizN/kwU74C5+wXUiHtZQGWcQSOsTZOjk2Il9wqFrrwistPw66NPuqg1O
	xDff6oWUetdBddor44U=;
Received: by exim-smtp-868bf69f6c-8kchf with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1sYWpX-00000000CoU-3Jhd; Mon, 29 Jul 2024 23:18:52 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	sudeep.holla@arm.com,
	quic_rjendra@quicinc.com,
	andre.przywara@arm.com,
	ulf.hansson@linaro.org,
	davidwronek@gmail.com,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	macromorgan@hotmail.com,
	linus.walleij@linaro.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	javier.carrasco.cruz@gmail.com,
	quic_kriskura@quicinc.com,
	lpieralisi@kernel.org,
	fekz115@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@mainlining.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 00/11] Add Nothing Phone (1) support
Date: Mon, 29 Jul 2024 23:18:07 +0300
Message-ID: <20240729201843.142918-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C65D76B8F852291B0987B035B9E54BA07F182A05F53808504093CF743E2B4E18D43DE06ABAFEAF6705C5699BC6C321C2869EC546CAE4A36CACB58C0E165F9F46AE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75644E22E05AA81AEB287FD4696A6DC2FA8DF7F3B2552694A4E2F5AFA99E116B42401471946AA11AF176DF2183F8FC7C0C8F626AC60F7C5938F08D7030A58E5AD1A62830130A00468AEEEE3FBA3A834EE7353EFBB55337566818EF6061DF249E94AAB4185F56D818E0235020D60A938C319BD9FE6965ECEBF389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B68CE9D8A6861299E6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249CECE95E22271FC9676E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B545F05E2AC4851F83AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735262FEC7FBD7D1F5BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5B15FC401B038DCAB5002B1117B3ED696AE2B5492C74B06420E58516B1639A14B823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF7B68F0B533CA1F756B1F41225A78AAA1A5E1909E3830DBA87EEF75AF6ADEEFD1EB3733EA1EE6A1F267C7AAC6E25A2086A032D1D7FAE62A63633D7FB3044967C2A053CA34DC4B4A4061A41C79C593F3F002C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WMT55LfpWa8w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949811F832B91E20AE7E2A80142CFDE86685D87446AF578F939E636D289BC4E1CBFF62C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B431B8944160407DD0C2EAA1E6BA7F9BE0FA19858876EF5BFA68F3CF0E9FE49B69543DADA4AE4E3247B699522B5268EDC4640F0F74BA7A2A329729BAF73F2561CA
X-7FA49CB5: 0D63561A33F958A591B612254AA1B90373CDF9D6CD53B7E0BC0B973DFF4BDD898941B15DA834481FA18204E546F3947CEF76DA0ED039B67DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637718608EF75D9B849389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3C839A5C92C19B5C335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6WD66ER7ctBxA==
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

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: Sudeep Holla <sudeep.holla@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
To: David Wronek <davidwronek@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Heiko Stuebner <heiko.stuebner@cherry.de>
To: "Rafał Miłecki" <rafal@milecki.pl>
To: Chris Morgan <macromorgan@hotmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Luca Weiss <luca@lucaweiss.eu>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Eugene Lepshy <fekz115@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: linux@mainlining.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (9):
  dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
  soc: qcom: socinfo: Add Soc IDs for SM7325 family
  cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
  soc: qcom: pd_mapper: Add SM7325 compatible
  dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible
  usb: typec: ucsi: Add qcom,sm7325-pmic-glink as needing PDOS quirk
  dt-bindings: arm: cpus: Add qcom kryo670 compatible
  dt-bindings: vendor-prefixes: Add Nothing Technology Limited
  dt-bindings: arm: qcom: Add SM7325 Nothing Phone 1

Eugene Lepshy (2):
  arm64: dts: qcom: Add SM7325 device tree
  arm64: dts: qcom: sm7325: Add device-tree for Nothing Phone 1

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts | 1261 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7325.dtsi          |   17 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |    1 +
 drivers/soc/qcom/qcom_pd_mapper.c             |    1 +
 drivers/soc/qcom/socinfo.c                    |    2 +
 drivers/usb/typec/ucsi/ucsi_glink.c           |    1 +
 include/dt-bindings/arm/qcom,ids.h            |    2 +
 12 files changed, 1296 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi

-- 
2.45.2


