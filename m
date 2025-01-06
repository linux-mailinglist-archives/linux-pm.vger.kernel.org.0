Return-Path: <linux-pm+bounces-19992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB80A03092
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 20:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2771B7A1397
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A51DF756;
	Mon,  6 Jan 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSSi77O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF991CEAD3;
	Mon,  6 Jan 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191678; cv=none; b=JiGjVxCWGKhIYCOdRNiPJNJDZr3KsNWSAWjK1CkPeyXBRFycwe24H7MQDlOVDSK3X0/kBl367q3mOMkKQpKyBVcVJvUf6p3jWz1dVR+e4cRbhIzzVsCDC0U/0j2Z1qj50t6bQaVWTLvaQOYod4ZE5jaV+ugvV1tXfR/CvtqyEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191678; c=relaxed/simple;
	bh=R+eSIUU1hfQkAUKGug034s6gzbXII3i8UbKc01om15Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aJ1nagq+xp6KvvXYFxqNfZ/jDXSNoDu1C3r/gr7HQ5v+d6/xba/PSdsp7t8pWXgiY5hUfAl1qH3IDgxWLOv5qeHiqKeYvjY2Hx24+2Go+t7ZDkRCuXijqGrpdPGGNY0P1H8FLaMO66bPrVR6cYuY7WDyJ5uxLAzfRcYZNsy2PW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSSi77O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C66EC4CED2;
	Mon,  6 Jan 2025 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191677;
	bh=R+eSIUU1hfQkAUKGug034s6gzbXII3i8UbKc01om15Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YfSSi77O6038ggQoJpoUoioFGttcqEj7s26K/oMkUb/kXZ5HMQAWq3aVLBzIWDln/
	 XuJ7YIL1pS3uKlJAWSpL1FrhRSeo/HvDb/HXWt+bmQi7Kn6z5m0Mvd1iBXjaoFYFFS
	 r1IsQiR66ORuX8m6ccG3NrQ9TEvk2xPXEUSPP1tM/ILlRNZZALL/641TmT9QqbK5Ae
	 iwZqDIP15w9gPkcHTIYZpWrNtkIHPv3Lu6tcvJ7w6Ur6qFZr1v0DPA7hd6bZZ4Gpgg
	 U8VUri81mp5QWPltZ83JXWtsAtElSaubmJEbjTP/xPRDYTivfT6eFsnpiUe1/lplUo
	 Z7mW70BfhUdiw==
Date: Mon, 06 Jan 2025 13:27:56 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, 
 Jean Delvare <jdelvare@suse.com>, linux-usb@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
In-Reply-To: <20250105174159.227831-1-mitltlatltl@gmail.com>
References: <20250105174159.227831-1-mitltlatltl@gmail.com>
Message-Id: <173619154479.838734.14441766781236450344.robh@kernel.org>
Subject: Re: [PATCH v2 0/5] platform: arm64: Huawei Matebook E Go embedded
 controller


On Mon, 06 Jan 2025 01:41:54 +0800, Pengyu Luo wrote:
> This adds binding, drivers and the DT support for the Huawei Matebook E Go
> (sc8280xp-based) Embedded Controller which is also found in Huawei Matebook
> E Go LTE (sc8180x-based), but I don't have the sc8180x one to perform tests,
> so this series enable support for sc8280xp variant only, this series provides
> the following features:
> 
> - battery and charger information report
> - charging thresholds control
> - FN lock (An alternative method)
> - LID switch detection
> - Temperature sensors
> - USB Type-C altmode
> - USB Type-C PD(high power)
> 
> Thanks to the work of Bjorn and Dmitry([1]), the work of Nikita([2]), writing a
> EC driver won't be suffering. This work refers a lot to their work, also, many
> other works. I mentioned them in the source file.
> 
> Depends: https://lore.kernel.org/linux-arm-msm/20241220160530.444864-1-mitltlatltl@gmail.com
> 
> [1] https://lore.kernel.org/all/20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org/
> [2] https://lore.kernel.org/all/20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru/
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241227171353.404432-1-mitltlatltl@gmail.com
> 
> global:
> - drop qcom's products(i.e. sc8180x, sx8280xp) everywhere, use 'product'-based instead(Krzysztof, Bryan)
> - drop Cc Nikita Travkin, we had discussed the device in PM.
> - add myself to MAINTAINERS
> 
> dt-binding:
> - fix building (Rob Herring (Arm))
> - remove unnecessary code (Krzysztof)
> - add bugzilla documentation, insights of gaokun(see [1] or patch[1/5]) (Krzysztof, Aiqun(Maria))
> - explain the difference between PMIC GLink and gaokun EC (Aiqun(Maria))
> 
> ec:
> - use Linux style comments (Krzysztof)
> - add a comment for mutex lock (Krzysztof)
> - add more kerneldoc for exported functions (Krzysztof)
> - eliminate unnecessary conditions (Bryan)
> - add a macro for check thresholds (Bryan)
> - improve English (Bryan)
> - use existing sysfs interface(hwmon, psy) whenever possible (Krzysztof)
> - use __le16 and related endianess conversion function for temp data (Ilpo)
> - drop alias for packet headers (Ilpo)
> - avoid hardcoding i2c msgs size (Aiqun(Maria))
> - add a comment for the sleep in critial region (Bryan, Aiqun(Maria))
> - use macro to construct packet (Bryan, Aiqun(Maria))
> 
> wmi:
> - dropped
> 
> ucsi:
> - reorder headers (Bryan)
> - a comment for the orientation map macro (Bryan)
> - make mux mode map more explicit(minus six is very clear now) (Bryan, Dmitry)
> - handle port update exceptions return (Bryan)
> - a comment for the UCSI quirks (Dmitry)
> - use the inline hint for the short register function (Dmitry)
> - use the API with delay to handle register instead of a direct sleep (Bryan)
> - handle unfinished initialization early
> 
> psy:
> - add charging related sysfs to here (Krzysztof, Dmitry)
> - document ABI for power_supply sysfs (Krzysztof)
> - drop charging threshold, use smart charging instead
> 
> dts:
> - correct indentation, properties' order. (Konrad)
> 
> ---
> Pengyu Luo (5):
>   dt-bindings: platform: Add Huawei Matebook E Go EC
>   platform: arm64: add Huawei Matebook E Go EC driver
>   usb: typec: ucsi: add Huawei Matebook E Go ucsi driver
>   power: supply: add Huawei Matebook E Go psy driver
>   arm64: dts: qcom: gaokun3: Add Embedded Controller node
> 
>  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
>  .../bindings/platform/huawei,gaokun-ec.yaml   | 127 +++
>  MAINTAINERS                                   |   9 +
>  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts | 139 ++++
>  drivers/platform/arm64/Kconfig                |  21 +
>  drivers/platform/arm64/Makefile               |   1 +
>  drivers/platform/arm64/huawei-gaokun-ec.c     | 767 ++++++++++++++++++
>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/huawei-gaokun-battery.c  | 548 +++++++++++++
>  drivers/usb/typec/ucsi/Kconfig                |  10 +
>  drivers/usb/typec/ucsi/Makefile               |   1 +
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c   | 524 ++++++++++++
>  .../linux/platform_data/huawei-gaokun-ec.h    |  79 ++
>  14 files changed, 2284 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
>  create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
>  create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
>  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
>  create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
>  create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h
> 
> --
> 2.47.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/sc8280xp-huawei-gaokun3.dtb' for 20250105174159.227831-1-mitltlatltl@gmail.com:

Warning: Duplicate compatible "huawei,gaokun3" found in schemas matching "$id":
	http://devicetree.org/schemas/platform/huawei,gaokun-ec.yaml#
	http://devicetree.org/schemas/arm/qcom.yaml#
arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dtb: embedded-controller@38: $nodename:0: '/' was expected
	from schema $id: http://devicetree.org/schemas/arm/qcom.yaml#
arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dtb: embedded-controller@38: compatible: 'oneOf' conditional failed, one must be fixed:
	['huawei,gaokun3', 'huawei,gaokun-ec'] is too short
	'huawei,gaokun3' is not one of ['qcom,apq8016-sbc', 'schneider,apq8016-hmibsc']
	'huawei,gaokun3' is not one of ['asus,sparrow', 'huawei,sturgeon', 'lg,lenok', 'samsung,matisse-wifi', 'samsung,milletwifi']
	'huawei,gaokun3' is not one of ['asus,nexus7-flo', 'lg,nexus4-mako', 'sony,xperia-yuga', 'qcom,apq8064-cm-qs600', 'qcom,apq8064-ifc6410']
	'huawei,gaokun3' is not one of ['qcom,apq8074-dragonboard']
	'huawei,gaokun3' is not one of ['qcom,apq8060-dragonboard', 'qcom,msm8660-surf']
	'huawei,gaokun3' is not one of ['qcom,apq8084-mtp', 'qcom,apq8084-sbc']
	'huawei,gaokun3' is not one of ['microsoft,dempsey', 'microsoft,makepeace', 'microsoft,moneypenny', 'motorola,falcon', 'samsung,ms013g', 'samsung,s3ve3g']
	'huawei,gaokun3' is not one of ['htc,memul', 'microsoft,superman-lte', 'microsoft,tesla', 'motorola,peregrine', 'samsung,matisselte']
	'huawei,gaokun3' is not one of ['wingtech,wt82918hd']
	'huawei,gaokun3' is not one of ['huawei,kiwi', 'longcheer,l9100', 'samsung,a7', 'sony,kanuti-tulip', 'square,apq8039-t2', 'wingtech,wt82918', 'wingtech,wt82918hdhw39']
	'huawei,gaokun3' is not one of ['sony,kugo-row', 'sony,suzu-row']
	'huawei,gaokun3' is not one of ['qcom,msm8960-cdp', 'samsung,expressatt']
	'huawei,gaokun3' is not one of ['lge,hammerhead', 'samsung,hlte', 'sony,xperia-amami', 'sony,xperia-honami']
	'huawei,gaokun3' is not one of ['fairphone,fp2', 'htc,m8', 'oneplus,bacon', 'samsung,klte', 'sony,xperia-aries', 'sony,xperia-castor', 'sony,xperia-leo']
	'huawei,gaokun3' is not one of ['samsung,kltechn']
	'huawei,gaokun3' is not one of ['acer,a1-724', 'alcatel,idol347', 'asus,z00l', 'gplus,fl8005a', 'huawei,g7', 'lg,c50', 'lg,m216', 'longcheer,l8910', 'longcheer,l8150', 'motorola,harpia', 'motorola,osprey', 'motorola,surnia', 'qcom,msm8916-mtp', 'samsung,a3u-eur', 'samsung,a5u-eur', 'samsung,e5', 'samsung,e7', 'samsung,fortuna3g', 'samsung,gprimeltecan', 'samsung,grandmax', 'samsung,grandprimelte', 'samsung,gt510', 'samsung,gt58', 'samsung,j3ltetw', 'samsung,j5', 'samsung,j5x', 'samsung,rossa', 'samsung,serranove', 'thwc,uf896', 'thwc,ufi001c', 'wingtech,wt86518', 'wingtech,wt86528', 'wingtech,wt88047', 'yiming,uz801-v3']
	'huawei,gaokun3' is not one of ['xiaomi,riva']
	'huawei,gaokun3' is not one of ['motorola,potter', 'xiaomi,daisy', 'xiaomi,mido', 'xiaomi,tissot', 'xiaomi,vince']
	'huawei,gaokun3' is not one of ['lg,bullhead', 'lg,h815', 'microsoft,talkman', 'xiaomi,libra']
	'huawei,gaokun3' is not one of ['sony,karin_windy']
	'huawei,gaokun3' is not one of ['huawei,angler', 'microsoft,cityman', 'sony,ivy-row', 'sony,karin-row', 'sony,satsuki-row', 'sony,sumire-row', 'sony,suzuran-row']
	'huawei,gaokun3' is not one of ['arrow,apq8096-db820c', 'inforce,ifc6640']
	'huawei,gaokun3' is not one of ['oneplus,oneplus3', 'oneplus,oneplus3t', 'qcom,msm8996-mtp', 'sony,dora-row', 'sony,kagura-row', 'sony,keyaki-row', 'xiaomi,gemini']
	'huawei,gaokun3' is not one of ['xiaomi,natrium', 'xiaomi,scorpio']
	'huawei,gaokun3' is not one of ['asus,novago-tp370ql', 'fxtec,pro1', 'hp,envy-x2', 'lenovo,miix-630', 'oneplus,cheeseburger', 'oneplus,dumpling', 'qcom,msm8998-mtp', 'sony,xperia-lilac', 'sony,xperia-maple', 'sony,xperia-poplar', 'xiaomi,sagit']
	'huawei,gaokun3' is not one of ['8dev,jalapeno', 'alfa-network,ap120c-ac']
	'huawei,gaokun3' is not one of ['qcom,ipq4019-ap-dk01.1-c1', 'qcom,ipq4019-ap-dk04.1-c3', 'qcom,ipq4019-ap-dk07.1-c1', 'qcom,ipq4019-ap-dk07.1-c2', 'qcom,ipq4019-dk04.1-c1']
	'huawei,gaokun3' is not one of ['qcom,ipq5018-rdp432-c2', 'tplink,archer-ax55-v1']
	'huawei,gaokun3' is not one of ['qcom,ipq5332-ap-mi01.2', 'qcom,ipq5332-ap-mi01.3', 'qcom,ipq5332-ap-mi01.6', 'qcom,ipq5332-ap-mi01.9']
	'huawei,gaokun3' is not one of ['qcom,ipq5424-rdp466']
	'huawei,gaokun3' is not one of ['mikrotik,rb3011', 'qcom,ipq8064-ap148']
	'huawei,gaokun3' is not one of ['qcom,ipq8074-hk01', 'qcom,ipq8074-hk10-c1', 'qcom,ipq8074-hk10-c2']
	'huawei,gaokun3' is not one of ['qcom,ipq9574-ap-al02-c2', 'qcom,ipq9574-ap-al02-c6', 'qcom,ipq9574-ap-al02-c7', 'qcom,ipq9574-ap-al02-c8', 'qcom,ipq9574-ap-al02-c9']
	'swir,mangoh-green-wp8548' was expected
	'huawei,gaokun3' is not one of ['qcom,qrb2210-rb1']
	'huawei,gaokun3' is not one of ['fairphone,fp5', 'qcom,qcm6490-idp', 'qcom,qcs6490-rb3gen2', 'shift,otter']
	'huawei,gaokun3' is not one of ['qcom,qdu1000-idp', 'qcom,qdu1000-x100']
	'huawei,gaokun3' is not one of ['qcom,qru1000-idp']
	'huawei,gaokun3' is not one of ['qcom,qar2130p']
	'huawei,gaokun3' is not one of ['acer,aspire1', 'qcom,sc7180-idp']
	'google,coachz-rev1' was expected
	'google,coachz' was expected
	'google,coachz-rev1-sku0' was expected
	'google,coachz-sku0' was expected
	'google,homestar-rev2' was expected
	'google,homestar-rev3' was expected
	'google,homestar' was expected
	'google,kingoftown-rev0' was expected
	'google,kingoftown' was expected
	'google,lazor-rev0' was expected
	'google,lazor-rev1' was expected
	'google,lazor-rev3' was expected
	'google,lazor-rev9' was expected
	'google,lazor' was expected
	'google,lazor-rev1-sku2' was expected
	'google,lazor-rev3-sku2' was expected
	'google,lazor-rev9-sku2' was expected
	'google,lazor-sku2' was expected
	'google,lazor-rev1-sku0' was expected
	'google,lazor-rev3-sku0' was expected
	'google,lazor-rev9-sku0' was expected
	'google,lazor-sku0' was expected
	'google,lazor-rev4-sku4' was expected
	'google,lazor-rev9-sku4' was expected
	'google,lazor-sku4' was expected
	'google,lazor-rev4-sku5' was expected
	'google,lazor-rev5-sku5' was expected
	'google,lazor-rev9-sku6' was expected
	'google,lazor-sku6' was expected
	'google,mrbland-rev0-sku0' was expected
	'google,mrbland-sku1536' was expected
	'google,mrbland-rev0-sku16' was expected
	'google,mrbland-sku1024' was expected
	'google,pazquel-sku5' was expected
	'google,pazquel-sku1' was expected
	'google,pazquel-sku6' was expected
	'google,pazquel-sku0' was expected
	'google,pazquel-sku22' was expected
	'google,pazquel-sku21' was expected
	'google,pompom-rev1' was expected
	'google,pompom-rev2' was expected
	'google,pompom' was expected
	'google,pompom-rev1-sku0' was expected
	'google,pompom-rev2-sku0' was expected
	'google,pompom-sku0' was expected
	'google,quackingstick-sku1537' was expected
	'google,quackingstick-sku1536' was expected
	'google,trogdor' was expected
	'google,trogdor-sku0' was expected
	'google,wormdingler-rev0-sku16' was expected
	'google,wormdingler-sku1024' was expected
	'google,wormdingler-sku1025' was expected
	'google,wormdingler-rev0-sku0' was expected
	'google,wormdingler-sku0' was expected
	'google,wormdingler-sku1' was expected
	'qcom,sc7280-crd' was expected
	'google,zoglin' was expected
	'google,zoglin-sku1536' was expected
	'qcom,sc7280-idp' was expected
	'qcom,sc7280-idp2' was expected
	'google,evoker' was expected
	'google,evoker-sku512' was expected
	'google,herobrine' was expected
	'google,villager-rev0' was expected
	'google,villager' was expected
	'google,villager-sku512' was expected
	'google,zombie' was expected
	'google,zombie-sku512' was expected
	'google,zombie-sku2' was expected
	'google,zombie-sku514' was expected
	'huawei,gaokun3' is not one of ['lenovo,flex-5g', 'microsoft,surface-prox', 'qcom,sc8180x-primus']
	'huawei,gaokun3' is not one of ['lenovo,tbx605f', 'motorola,ali']
	'huawei,gaokun3' is not one of ['sony,discovery-row', 'sony,kirin-row', 'sony,pioneer-row', 'sony,voyager-row']
	'huawei,gaokun3' is not one of ['inforce,ifc6560']
	'huawei,gaokun3' is not one of ['fairphone,fp3', 'motorola,ocean']
	'huawei,gaokun3' is not one of ['sony,mermaid-row']
	'huawei,gaokun3' is not one of ['xiaomi,lavender']
	'huawei,gaokun3' is not one of ['google,sargo']
	'huawei,gaokun3' is not one of ['qcom,sdx55-mtp', 'qcom,sdx55-telit-fn980-tlb', 'qcom,sdx55-t55']
	'huawei,gaokun3' is not one of ['qcom,sdx65-mtp']
	'huawei,gaokun3' is not one of ['qcom,sdx75-idp']
	'huawei,gaokun3' is not one of ['qcom,ipq6018-cp01', 'qcom,ipq6018-cp01-c1']
	'huawei,gaokun3' is not one of ['qcom,qcs404-evb-1000', 'qcom,qcs404-evb-4000']
	'huawei,gaokun3' is not one of ['qcom,qcs8300-ride']
	'huawei,gaokun3' is not one of ['qcom,qcs615-ride']
	'huawei,gaokun3' is not one of ['qcom,sa8155p-adp']
	'huawei,gaokun3' is not one of ['qcom,sa8295p-adp', 'qcom,sa8540p-ride']
	'huawei,gaokun3' is not one of ['qcom,sa8775p-ride', 'qcom,sa8775p-ride-r3']
	'huawei,gaokun3' is not one of ['qcom,qcs9100-ride', 'qcom,qcs9100-ride-r3']
	'huawei,gaokun3' is not one of ['google,cheza', 'google,cheza-rev1', 'google,cheza-rev2', 'lenovo,yoga-c630', 'lg,judyln', 'lg,judyp', 'oneplus,enchilada', 'oneplus,fajita', 'qcom,sdm845-mtp', 'shift,axolotl', 'samsung,starqltechn', 'samsung,w737', 'sony,akari-row', 'sony,akatsuki-row', 'sony,apollo-row', 'thundercomm,db845c', 'xiaomi,beryllium', 'xiaomi,beryllium-ebbg', 'xiaomi,polaris']
	'huawei,gaokun3' is not one of ['oneplus,billie2']
	'huawei,gaokun3' is not one of ['qcom,qrb4210-rb2']
	'huawei,gaokun3' is not one of ['qcom,sm4450-qrd']
	'huawei,gaokun3' is not one of ['fxtec,pro1x']
	'huawei,gaokun3' is not one of ['lenovo,j606f']
	'huawei,gaokun3' is not one of ['sony,pdx201', 'xiaomi,laurel-sprout']
	'huawei,gaokun3' is not one of ['sony,pdx213']
	'huawei,gaokun3' is not one of ['sony,pdx225']
	'huawei,gaokun3' is not one of ['xiaomi,curtana', 'xiaomi,joyeuse']
	'huawei,gaokun3' is not one of ['fairphone,fp4']
	'huawei,gaokun3' is not one of ['nothing,spacewar']
	'huawei,gaokun3' is not one of ['microsoft,surface-duo', 'qcom,sm8150-hdk', 'qcom,sm8150-mtp', 'sony,bahamut-generic', 'sony,griffin-generic']
	'huawei,gaokun3' is not one of ['qcom,qrb5165-rb5', 'qcom,sm8250-hdk', 'qcom,sm8250-mtp', 'sony,pdx203-generic', 'sony,pdx206-generic', 'xiaomi,elish', 'xiaomi,pipa']
	'huawei,gaokun3' is not one of ['microsoft,surface-duo2', 'qcom,sm8350-hdk', 'qcom,sm8350-mtp', 'sony,pdx214-generic', 'sony,pdx215-generic']
	'huawei,gaokun3' is not one of ['qcom,sm8450-hdk', 'qcom,sm8450-qrd', 'sony,pdx223', 'sony,pdx224']
	'huawei,gaokun3' is not one of ['qcom,sm8550-hdk', 'qcom,sm8550-mtp', 'qcom,sm8550-qrd', 'samsung,q5q', 'sony,pdx234']
	'huawei,gaokun3' is not one of ['qcom,qcs8550-aim300-aiot']
	'huawei,gaokun3' is not one of ['qcom,sm8650-hdk', 'qcom,sm8650-mtp', 'qcom,sm8650-qrd']
	'huawei,gaokun3' is not one of ['qcom,x1e001de-devkit']
	'huawei,gaokun3' is not one of ['lenovo,thinkpad-t14s']
	'huawei,gaokun3' is not one of ['asus,vivobook-s15', 'dell,xps13-9345', 'hp,omnibook-x14', 'lenovo,yoga-slim7x', 'microsoft,romulus13', 'microsoft,romulus15', 'qcom,x1e80100-crd', 'qcom,x1e80100-qcp']
	'huawei,gaokun3' is not one of ['qcom,x1p42100-crd']
	'qcom,apq8016' was expected
	'qcom,apq8026' was expected
	'qcom,apq8064' was expected
	'qcom,apq8074' was expected
	'qcom,msm8660' was expected
	'qcom,apq8084' was expected
	'qcom,msm8226' was expected
	'qcom,msm8926' was expected
	'qcom,msm8929' was expected
	'qcom,msm8939' was expected
	'qcom,msm8956' was expected
	'qcom,msm8960' was expected
	'qcom,msm8974' was expected
	'qcom,msm8974pro' was expected
	'samsung,klte' was expected
	'qcom,msm8916' was expected
	'qcom,msm8917' was expected
	'qcom,msm8953' was expected
	'qcom,msm8992' was expected
	'qcom,apq8094' was expected
	'qcom,msm8994' was expected
	'qcom,apq8096-sbc' was expected
	'qcom,msm8996' was expected
	'qcom,msm8996pro' was expected
	'qcom,msm8998' was expected
	'qcom,ipq4018' was expected
	'qcom,ipq4019' was expected
	'qcom,ipq5018' was expected
	'qcom,ipq5332' was expected
	'qcom,ipq5424' was expected
	'qcom,ipq8064' was expected
	'qcom,ipq8074' was expected
	'qcom,ipq9574' was expected
	'swir,wp8548' was expected
	'qcom,qrb2210' was expected
	'qcom,qcm6490' was expected
	'qcom,qdu1000' was expected
	'qcom,qru1000' was expected
	'qcom,sar2130p' was expected
	'qcom,sc7180' was expected
	'google,coachz-rev2' was expected
	'google,coachz-rev2-sku0' was expected
	'google,homestar-rev23' was expected
	'google,lazor-rev2' was expected
	'google,lazor-rev4' was expected
	'google,lazor-rev2-sku2' was expected
	'google,lazor-rev4-sku2' was expected
	'google,lazor-rev2-sku0' was expected
	'google,lazor-rev4-sku0' was expected
	'google,lazor-rev9-sku10' was expected
	'google,lazor-sku10' was expected
	'google,lazor-rev5-sku4' was expected
	'google,lazor-rev9-sku15' was expected
	'google,lazor-sku15' was expected
	'google,lazor-rev5-sku6' was expected
	'google,lazor-rev9-sku18' was expected
	'google,lazor-sku18' was expected
	'google,mrbland-sku768' was expected
	'google,pazquel-sku4' was expected
	'google,pazquel-sku2' was expected
	'google,pazquel-sku20' was expected
	'google,hoglin-rev3' was expected
	'google,hoglin' was expected
	'google,hoglin-sku1536' was expected
	'google,senor' was expected
	'google,piglin' was expected
	'qcom,sc7280' was expected
	'google,zombie-sku3' was expected
	'qcom,sc8180x' was expected
	'qcom,sc8280xp' was expected
	'qcom,sdm450' was expected
	'qcom,sdm630' was expected
	'qcom,sda660' was expected
	'qcom,sdm632' was expected
	'qcom,sdm636' was expected
	'qcom,sdm660' was expected
	'qcom,sdm670' was expected
	'qcom,sdx55' was expected
	'qcom,sdx65' was expected
	'qcom,sdx75' was expected
	'qcom,ipq6018' was expected
	'qcom,qcs404-evb' was expected
	'qcom,qcs8300' was expected
	'qcom,qcs615' was expected
	'qcom,sa8155p' was expected
	'qcom,sa8540p' was expected
	'qcom,sa8775p' was expected
	'qcom,qcs9100' was expected
	'qcom,sdm845' was expected
	'qcom,sm4250' was expected
	'qcom,qrb4210' was expected
	'qcom,sm4450' was expected
	'qcom,sm6115' was expected
	'qcom,sm6115p' was expected
	'qcom,sm6125' was expected
	'qcom,sm6350' was expected
	'qcom,sm6375' was expected
	'qcom,sm7125' was expected
	'qcom,sm7225' was expected
	'qcom,sm7325' was expected
	'qcom,sm8150' was expected
	'qcom,sm8250' was expected
	'qcom,sm8350' was expected
	'qcom,sm8450' was expected
	'qcom,sm8550' was expected
	'qcom,qcs8550-aim300' was expected
	'qcom,sm8650' was expected
	'qcom,x1e001de' was expected
	'qcom,x1e78100' was expected
	'qcom,x1e80100' was expected
	'qcom,x1p42100' was expected
	from schema $id: http://devicetree.org/schemas/arm/qcom.yaml#






