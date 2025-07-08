Return-Path: <linux-pm+bounces-30363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0AAFCAAB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982847A33B6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE482DCF49;
	Tue,  8 Jul 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dWXqJbYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3642DCBFA
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978544; cv=none; b=umb/9K97tjEb/rvLypIwy1pI2uu6UpqcWQ1DnqJNHVMEPGrnQ2yueL1JjREUh4AqZ8kFKYAi/L0PHVI17ZC/WJT9v4r1JXdLkxD/xvE3TfJ5l3e2Nl2+gLpRGuTwThKCyZOlptwIJeiKAwdqCH2e4XyaFXSquSyxMEfeU4TJ7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978544; c=relaxed/simple;
	bh=OMUTx42+lxnfbmDa4w9KRyTNqE2cIBR6M9QVHF4w1fI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pD2QgAx7dKWIExwkBbutixeMCJFcvwOCddzV9qU4m1Y8uaCQCdUFxgbuFjgazlpuBAaJ/kd/pPbwY8pGHnZ7kCQPzhPk7ok+DDqwShpgxXy4mh8rTn1XrRsYW1Hz/w0VZP2DKT4lgR51eCkQ3nKvbmv072zYx1b18eSWp3tEzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dWXqJbYT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1096201166b.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751978541; x=1752583341; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krWI5dKupRfQc3/61VnzeAoMeO2jYhgWh27WUPDNkkI=;
        b=dWXqJbYT4l0gvL7r8Bk7j3OlqbHVe7abqQS/crSvNpbKx0hQJa7XCbzm9vh1a6ouoN
         65coz8Ejmlkd9cB/NUD6Oh6zz0aMNJ3NBFpTlgfWL2WG4RIZIX4w8e2GHfIX8+Dc9b9g
         ZWzc+Vgi6AEn2o5N0LAFDJf3NtjRKjqUhcKdQt/pJNT3vfNeGrPo4yO7lguh0UGxPV/9
         kXags8eDsrnf07OBD4OG008qKpk29DcGjytFo6HJLeVycrbINXC1a6X/jHxxTyGsRzpG
         x57ln0NusPENSiDS5ElopQv6s5pNRZMw3Mea0PUA27J69fDkFMGkSXroci04BU2JUUXq
         53pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978541; x=1752583341;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krWI5dKupRfQc3/61VnzeAoMeO2jYhgWh27WUPDNkkI=;
        b=n5Gkz7RzyUmzph/VSNap2vAi4ezIxFy0dpZux8AN+OmS936JDW73qKx3Sc3p/5ovYB
         DdWvnwpvY2b6N+asPyIBw19jRQKyI/47lWalHCSAb11YYWUhKO8QmrTALICQvdNjHXyj
         K4k4jXNdN+QEoRdnQuxrWjviuvAX/J7mcdxV3onUKbiu5ScTo+Na5ngWaI3QPSmEyl7H
         mM6ayaQBzCTQW5A2Nm2FB/IpF7198FoNw6RcGXRxSacIfES7/Rv6iAg/+EnZkJIvh0Ov
         +NIavk4sCsClAKJlYyX5RobJQxCIZ1y3YmhTq9cknTNQmAI8xBwwEphzK4Kek5Oo/WFl
         5FwA==
X-Forwarded-Encrypted: i=1; AJvYcCUlUs+QgNljOfVkj29VLIXPPDNxTmd8DfC50zOVJN+0RfqC1voVHj/3u1nQWLdFbdpulbCBGbqCPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99ABPEpbhIaQxMHiwlZb2sZCWsO047AF4FaiYwTz+9xl5C+N6
	KYS4N944FKvkQuqrJtJbyqu0otEz8yY+GHvQfc2EQ8kSZntyUwImk6ISHTIr9MLwMVM=
X-Gm-Gg: ASbGnctFDzcE+lUieAx2/wtcwfT1x3BMrCZ3UHZRP3CDNslEHsZ2sMpnErEPwgipV5M
	QTka8HqkJY5HZQuLon8SmfFUoHCINUDysG6ztnS4rMbUZLQPf8GyIsCa/BNcPb0kbEcs+5dgJwN
	RXe6mG7cMP9eOWemVeAk+KCpS3zRZQdtgSXCg9JF+wU3Y+jb/c1XJHjNI4BFN0Kssq67fjPcbm9
	9mbxjFsSFztA/hJJ27H53jN0GTxStqUgQuwplWjkDImKVsbwYikEPIyfaLvLs9WiMuGAH/8+L1R
	iPpbO7MZ8gGRJEXhceUrXxmYY93nGsos9NLR4u0hxYAZArFmjOXsJdyrQ0MANPDokIWanvhxcob
	6gSzhumUxgmLbvcwgAR4ZhO3RBVb2Z1M=
X-Google-Smtp-Source: AGHT+IF8+quXXledQG534WGGLgZTN7F2C1w8IIy/x0D8Dajv4m6QB5Hjruw4R2tZAmvqG+s4Kctcmg==
X-Received: by 2002:a17:907:3f0a:b0:ad8:91e4:a931 with SMTP id a640c23a62f3a-ae6b2b34160mr265150966b.26.1751978540601;
        Tue, 08 Jul 2025 05:42:20 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm889858666b.67.2025.07.08.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 05:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 14:42:19 +0200
Message-Id: <DB6OK61BL9ZS.31XB5TN5YTX62@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Georgi Djakov"
 <djakov@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
 <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>
In-Reply-To: <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>

On Tue Jul 8, 2025 at 1:30 PM CEST, Konrad Dybcio wrote:
> On 7/8/25 12:20 PM, Luca Weiss wrote:
>> Add driver for the Qualcomm interconnect buses found in Milos based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> [...]
>
>> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] =3D {
>> +};
>
> You can remove the empty bcm arrays and .(num_)bcms assignments
> for them

Sure!

>
> [...]
>
>> +static const struct of_device_id qnoc_of_match[] =3D {
>> +	{ .compatible =3D "qcom,milos-aggre1-noc", .data =3D &milos_aggre1_noc=
},
>> +	{ .compatible =3D "qcom,milos-aggre2-noc", .data =3D &milos_aggre2_noc=
},
>> +	{ .compatible =3D "qcom,milos-clk-virt", .data =3D &milos_clk_virt},
>> +	{ .compatible =3D "qcom,milos-cnoc-cfg", .data =3D &milos_cnoc_cfg},
>> +	{ .compatible =3D "qcom,milos-cnoc-main", .data =3D &milos_cnoc_main},
>> +	{ .compatible =3D "qcom,milos-gem-noc", .data =3D &milos_gem_noc},
>> +	{ .compatible =3D "qcom,milos-lpass-ag-noc", .data =3D &milos_lpass_ag=
_noc},
>> +	{ .compatible =3D "qcom,milos-mc-virt", .data =3D &milos_mc_virt},
>> +	{ .compatible =3D "qcom,milos-mmss-noc", .data =3D &milos_mmss_noc},
>> +	{ .compatible =3D "qcom,milos-nsp-noc", .data =3D &milos_nsp_noc},
>> +	{ .compatible =3D "qcom,milos-pcie-anoc", .data =3D &milos_pcie_anoc},
>> +	{ .compatible =3D "qcom,milos-system-noc", .data =3D &milos_system_noc=
},
>> +	{ }
>
> a space before '}' would be neat

There is a space :)

>
> Konrad
>
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver =3D {
>> +	.probe =3D qcom_icc_rpmh_probe,
>> +	.remove =3D qcom_icc_rpmh_remove,
>> +	.driver =3D {
>> +		.name =3D "qnoc-milos",
>> +		.of_match_table =3D qnoc_of_match,
>> +		.sync_state =3D icc_sync_state,
>
> Are there any issues with sync_state? (hopefully not)

Don't think so, I don't see any sync_state pending warnings in dmesg so
I assume it's 'synced'? Anything I should look out for in particular?

Also since it looks like I'll anyways send a v3, I've already ported the
QoS settings, and don't think I'm seeing any issues booting up with
that. So I'll include it with v3.

Regards
Luca

>
> Konrad


