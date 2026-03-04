Return-Path: <linux-pm+bounces-43551-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEldNar1p2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43551-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:04:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F691FD232
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07EE4309B9B2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499F395D8F;
	Wed,  4 Mar 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmgN3vXa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMQZF//T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF223947B4
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614991; cv=none; b=JlFJhlVPGYffpbI6uh9jzz5UWoUDqJVkChaJ8o5dNjzSUojYUXmzBSFGb3RlsrPBp8zs9dRcZXa/E9FqQZv9YkSbdi7M2SfAD3q1wxw/tomn+pVnh82oMYwRiwrSTnHCLO7tNOlnjYQATZ11GR/lchFBXXOsp6HZblo3lwcmGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614991; c=relaxed/simple;
	bh=HYhh5175MjWDCW3hz6XHSycHBy64wcX8wW09sbGX2gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l72L7BEb5LTLMnj/sG0HSvYs58EQilpsVehXmc4ONnNjrir5UEoQA7nxze5QoagQvT0fcbu/ea5HsSi16+D5HBwsBcdOia3Pc2vK4tEijsbn/otf4UgddBGab9MuTS8+LJyku1gLUu0X08B9DwSWlA8evZeXqg8pFlgEauJTS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CmgN3vXa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMQZF//T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SVi41072461
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 09:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=; b=CmgN3vXaekSaNadh
	ZT7wjE5zhtUjH9dVHbJ/+23pBDJMMktK3ugLgmdPUjhKl5R7NQNX5eB8GvZihjmW
	SG8Z8+qtv68sx2172d7+3YzCi+PmbIlW7tAIEwpkwhecp3TlrV6hz2CdV23d1s6R
	og0TtdZpDSuXvxKVpODc7/TaWjzGKlj2QJxLmTT5BTKHqnZgz532HTNjzzKewK5S
	82hJ1D07JKQ290NCCjiaC0iObNREoolAm8kCj6bb9KnjDVxQK4bp0IXZGZwzcxwF
	to7XSDq6cGPz1PsdMqbCXjO+3O98PpPwE5Q6bWvEaG9UI3y6LChwykzE4InKTHca
	thwXYQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpcxfh0hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 09:03:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb403842b6so4865378385a.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614987; x=1773219787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=;
        b=MMQZF//TlVx1tqe02PpHtMy64/BR2XBa9mVKCF5+uDDbnnhskGzOrU1w6jh+puoF92
         rpXkX4AKykNXm0Hslw1NF4e6Wez9NAM16H+ItcUJfZ+BfoShtL/AwsnWRtRd2O0wJxWx
         i9Ldmuyq1BU0+4M27re9Vwm6YTr3A5mzCf3Y+ZViqB1xO5rSybK7bOOEg2LOpirUGaNp
         +zaTFc7E2Mv717288PSkpYxsaYwZPTmKfTqU9DBe/QLU82PUArGNzeYDFdslC3n0Za9c
         7GQWCzbabnEphGrf7R50A9hmlCvxrVYkxo1vZQQEQXfj/4AKHPk8InMI51fZPcGJ5Uxg
         twRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614987; x=1773219787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=;
        b=HtwRA6d7jIiRlfkjho9jyDmHlPh4AyI+CsNyRyKmZgcWUhiVlIyugQwixITLeegdFe
         WjPnYXqSGnm7s/zdy00w8n2l5LXDf2tuTEA+LcAX7ATIv6bjkW0ZdaCi8wXUbzVJci2i
         NMVz6VzC7BK+4bDtMiZrBYManx2SsomXMy8GnmxnMlp42sEvpQ+Qmv0lIkQMfWL+HBoC
         knyXvM8jKZ57XW/Qe8LD6LeO+Ib9gRJCbr1/rIjPfPOR7u+0v0rCZnU/wjcr1ndFUSdL
         C7Hv1Ocuij/gySJcTmbnATpd7mlxyZlh2YoT1uqW3QuUd24NrvgKObJh2IKCyfSzB9NN
         Ellg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKBcOupUTj3hGt2eclUW83ev2kfZVu88bMZKKzYUPxyh5NFlz/KsJg5mvSHEHnLBvS9H7kt9t0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2gjrkhhmN0COxfhuc2BNsP7ljmj5L+yyOwpO8tICuWebIiqV
	qTKP7IBGL1Ux7hTQNTBLMzcX4XFhT0ZZl8XdzPXQ3UCmjeG3r6RIlbdcUU0CrVe7yWtlVAEsp4h
	wjR571dHZe1WTPAxJAF9fwCJ2DVBWvKo2MEDt9+VMVIhbT4d9opgwOsJuCWlY+jZYy0zONQ==
X-Gm-Gg: ATEYQzy0B8/n77bex0PFySDHF2wTmdkbM03oPKn9kj2kZpa/5TJaX3dJ5Z7e2FtLvFn
	x4xHmJ7yVUU0h+Yze56v2UshwVPSqa+nhagwQi7nw4P2fAbNckdKKyJH2N0DzUi59UpvJiAk1e0
	glVkxJfWlCpQCteDLUZ0CJjzv2a4BUkZDjHauMrVAKNGu5qH5IYlzbUc7mcPyFNDpdFxs+LezZz
	MbyfxCk/CPNpq2DYC6fOM2Lwv9vGZPUTSHuIWNf28dFAH7+5MQp1Ji26VmCDMuHNoFIZr5jLVGt
	g4vvWh6I8QBwlaB+imkYemj+zxUrNNc20+hVudM/qUO72xTPFAFMt2yjfRzWqjl+zHECuidkjeh
	kDdec+8pdOHKyvRIQGpvf12+iMyurW1+0tCkOuH8I/ZqZxferB3Vf
X-Received: by 2002:a05:620a:1928:b0:8cb:395e:2b3b with SMTP id af79cd13be357-8cd5af13613mr171204685a.35.1772614986713;
        Wed, 04 Mar 2026 01:03:06 -0800 (PST)
X-Received: by 2002:a05:620a:1928:b0:8cb:395e:2b3b with SMTP id af79cd13be357-8cd5af13613mr171201185a.35.1772614986228;
        Wed, 04 Mar 2026 01:03:06 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:04 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:25 +0100
Subject: [PATCH 04/14] net: mdio: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-4-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HYhh5175MjWDCW3hz6XHSycHBy64wcX8wW09sbGX2gk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UtHU+xio9zdO/39jyV4sjCCRssE3sSle1F9
 oGNe0udP32JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1LQAKCRAFnS7L/zaE
 w9XhEACRbGUQlbl1BceBLfGv1qLoKBaiUTxgwkTWKHN/9SH7vkusJhdtf7kodxfePqY4X6DdocO
 Y8J3BLBxYwWhhbSpRUBiTN5hm0e3LQ659eYtRyYQXZc0EwxeF/SW7J0W6aoPCnbRotyVLi8AELW
 3eTait+WSivwEw4Cu2IITjlJh9a308KeWw3vyvggIuIp//7I+AsB5x6XjLXlLZQFpErC+LVUjVk
 t9PA3piMLGXAym/P4tFgSYhAus6gdj4FFhtvf54JN5RA8fX7MhNlkqmDxWxU/jwWHMFZfNQ2xsk
 McgwcMZMLc44FZWKYQxwGYA7sYj6q7jVSjuhCDqu/lO99advfd2avAlB1rUTxkxLplVzyazwH/e
 ZaFppHMLvMnWGGToCN/Pp6f2hZ97FOOfHnRfGU4TXiTVbAGIn9BYhVqaRcxFr7yaHKAi0XY5X7e
 ad94XLXh5XYEv2uKCm7cU4JI2NvD7Mh+EK3wxA184srvnT7tRET6BeGKZUX5C5S5SNV81VbKjzE
 ced5x9ixEkDibW1GixB57MKH3kDaAVs36QuGY2w6Ghpy9p6VtzEb6kTuAnPoJI7M1zKyVL6Kz/p
 xFdxte9/mEi1MhtXrNVI86b8HLFK0uaR8FjVbOWzeBGSA0J6Z3vcPbQ0AdmRGnvPBElOAJayp7t
 XmJyi+/sS06aLHA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 0Mu_rKCV2SBzexAvQeYld_IhKFKD7Wee
X-Authority-Analysis: v=2.4 cv=R4gO2NRX c=1 sm=1 tr=0 ts=69a7f54b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=wUbH2sL_sFSbtn_y6v8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX6UCqegkcZ2U+
 wJUFQ7ZktT77PfP1+NyHFdT45dkhqBvAauJ5zy9Ya4TDehhFCl4G+dbTDO2cE7UJfLbga5GrUEK
 G+1ww8Frmjx+14ZYXhefTP14us27N6zZPqSGLWNVjhgQ9b9ZGIVgiqTL404LzvLwaJpGoWaSMrT
 JigKNZtzklfXRZBJoErNSNvIWWlyGIeYAeyqiEYzq1IuJClYRqPY7cd7Mb7wAWQitsOcNOeYl6W
 uYKtgYDFnINpdrXkyhJdSVRqyT9eHnDPueEwoPwgoHxhbceALaCTcczeYo3bApE8CTuTr91yzwm
 i5a/jecn1z5mlvtkCiCbWFy1yY6sL1Gw3as81CflSJt2Qwo52rVpqwYYT4aEAP3CmprQiKHNvXy
 VBnZFHayeq80JZ5lpMPUNSMS6MAGHRpXj1gn7HO3nxLDjn51iQcx9bxvvAjuuQWA4XbJFtCdRir
 6n6mNuNiWz/jcIV3GUQ==
X-Proofpoint-GUID: 0Mu_rKCV2SBzexAvQeYld_IhKFKD7Wee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: 61F691FD232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43551-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/mdio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911b7d72e7289951fca90282d731913d..d7ca7fce7a3b86a435fac035534260146f114bc7 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -247,7 +247,7 @@ config MDIO_BUS_MUX_BCM_IPROC
 
 config MDIO_BUS_MUX_GPIO
 	tristate "GPIO controlled MDIO bus multiplexers"
-	depends on OF_GPIO && OF_MDIO
+	depends on OF_MDIO
 	select MDIO_BUS_MUX
 	help
 	  This module provides a driver for MDIO bus multiplexers that

-- 
2.47.3


