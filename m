Return-Path: <linux-pm+bounces-43549-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKrALMz1p2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43549-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:05:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7131FD283
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C405530E505B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC8391849;
	Wed,  4 Mar 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CazoV7ZG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aL6ef95U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3039478E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614982; cv=none; b=qIwWr//vzQ8xhajLNQREa2OLKbzFISWrG2L/o4GevHCVCEZCMbKC7anlGa6petks8WXunL+ddhqAQ52FfMyf00RnANtkHy742Yk9GZ7CISaj3fDr1gUcmEeBzZVhCBMUTA76PMogEkXdFLe0r0rEORcjuk2RUCnJv9cR/1x8Zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614982; c=relaxed/simple;
	bh=elGyJX6kiF5U80wwgrS1gevNlE86QtaFWMPcJZOJ110=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBLU9Iqwhg2n+IGezlSDuj+Kgut86c4RLPpYh3UitaEINkf5o4WgBu6ZUprtJ5tXwyoHi1NE2UPNr4n6gHFvCnJjsWhpNAF2uR7UlwWcrGiKfPRt3QyAOrR5y8DGJwxU8nYVnLwMbIjLvitbLWSX5pJD498B5ECW78jFr5WYvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CazoV7ZG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aL6ef95U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQLJ2861140
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 09:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQFHrqy+7ET89/6DOEboD9MvIg0jU8dDQ0sv+yzIoZo=; b=CazoV7ZGoy+xYvkW
	cCJg6ClwtEdshtyKOluMNv36otWlt5w1TDCYQ+bImxm/DRWwpCmu07h+Y1mvNmO5
	+hM1wnV+qfEXZ1/g73CCmJlHqgibwXu1PmqpDsTIELhobC5+9kE23b0dgz5e+yCr
	a3iAYAZah49tETdO1Y3PEYiwldEgVdLyrE/ibxq+kMbix3Mu4I2pDDdr75h27WJ5
	p54SIGKrE+7OwsTZhT3+SBBBSdxU3nYE5q6p+ztUB+1ipIxADEG0ZKZwF/a73jRD
	bVp7G5Dc0+YxpHnqgBCeO4s9X9JuWTXzfAPJcvSzFQqIzoei2Vhum+GBwB77CHca
	f7xWeg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9k91k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 09:02:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4817f3c8so3722504485a.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614978; x=1773219778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQFHrqy+7ET89/6DOEboD9MvIg0jU8dDQ0sv+yzIoZo=;
        b=aL6ef95UcJThpwco7tIhPMSq/T/rdLsZH6kPvur3/nhpbYQx1ql0a53m+FBz0oHpzh
         xIGBZKTGY27m58mkBcW2gNgqzqLRmR8SIibH3+4uuRrHkjOoxFDhZoaNWgYgtqmNnvNp
         aYAv+4Hzdzxvg1TDnlYFWXbucFRFnxyX94QVFwJ8Ymixoz7mQHNEAcON4U5Rp1FyQ1AA
         coLnXr8i1LN3AQmI2Dm1T5RvwJuz9UjVuazPU/aclUctBu1VcUeOriFnn/21i/xTlYxj
         gWDkkxVdPjUN9C9sFFbjyaHFW24BgAUZcWEsjC8FY7s3bTg9PmnInKmSUULaT2IjX59S
         XKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614978; x=1773219778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zQFHrqy+7ET89/6DOEboD9MvIg0jU8dDQ0sv+yzIoZo=;
        b=XLBYyZ7jOWnztjmqbbLuuCBsTURibztk6kUFFsXc16tHDuvikIhMAfKcpK+qXS+UG4
         zJHVkMgfOIPyJ9r+nmF4UZSh4o1H222pgs3YQgjFD913zpkuM1/3qxq7+kTzZrfMfA+V
         azOBGoWAm2a8nEHIx80Zunw+bhFKOH+FxtGTSZmnwmzRqjylgV/nJDiOSH2AthqPAgRh
         dJv2/tviT6OaHhm8WVbQ8n2qc4C/KRAro8uzOJJDHQMnmFC1O/QLbk2QYOoAc7X+59LI
         Tz7NgpFXMqJoAK2wxOPpA3tFhlhRH/8NaY125JQ38ItT2R0fbv8oScdZN3fn+PWtI0uI
         l9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsG9X3dWCDEOgjdbFYqUGETNYwORD83tvojJvsMf87S7M+5/t8SsGFzU+VwxvRzBrNkM/S+a1mJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEr4N1kWw3Gs1pVCWp0E8WGv3SCItSrOHG/GaGxKJu1Y4wKGn7
	iZ7r3r5ggeSewc6nZeMstPgDVn30GWxVqiW0TlwknXL9ObO5OUNDNPCrUkg9c9zSAPuPrOsl/QN
	vsFx2VmSbIpQBYIWGivbi7c6mpIQa6Ss7x0j1L0Ir4NfYBSK7DPrhRLSUOrHfs7p1DNmxag==
X-Gm-Gg: ATEYQzxAk0TtfS/fKJDIDIFU0+tLf/62Wn8cAULkCCmnVyA5ePZT0iiG0OURtVqvKW2
	xlYO1o8xpwfY5xsAVb0oq5N8oNOVP25DUX5cX0vc6ln+LxD+wPvMIZ7iyh2jQGKX9n7S018/9ft
	J31MJ7piYPc/yDD0scI3/43R7l3hfBFMsIDAy48Ls3DR869HxvwWrznxgCy/yVhJSo0XL+P4YSe
	k8xRw0ctnQnBINcaj1Cojl/M3CDd+PhEqhuENFftqpIq37fhplligt0PSTJBUQ0VOzH5kVDSKq0
	E2dHJcI9Ub5G1fgSbNup/xv1zwr7NtlLUVG6idHCqLiz84pAAQNRBFC1wKWlRSS9n4n6hyNV4j3
	rzMeNPgpm/wp6SGJe03bGo6Q7JSCw39i6aZEZ5KeTutnJE6nLFiuV
X-Received: by 2002:a05:620a:1916:b0:8ca:90de:43f1 with SMTP id af79cd13be357-8cd5afa5022mr134816585a.63.1772614978020;
        Wed, 04 Mar 2026 01:02:58 -0800 (PST)
X-Received: by 2002:a05:620a:1916:b0:8ca:90de:43f1 with SMTP id af79cd13be357-8cd5afa5022mr134812685a.63.1772614977445;
        Wed, 04 Mar 2026 01:02:57 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:02:56 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:23 +0100
Subject: [PATCH 02/14] arc: axs10x: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-2-d597916e79e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=736;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=elGyJX6kiF5U80wwgrS1gevNlE86QtaFWMPcJZOJ110=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/Ur8cTWvTe41Vx/7b1PfM0xlmUQmzL4DULT4
 JDfBXBxP0yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1KwAKCRAFnS7L/zaE
 w42GEACAPu61giLCN8WXIPA8YMaONEdH0iiFGuhCO5j8uA/ORhhiYa+GLkJFndF7gMOXfafU7o4
 sirVD8YRozigYhUq7uBAdHBd7B4/UHJOoPc7fXh9Zcdvx2SBGB1fiBt4QSB3axS/EDKoemsR+UQ
 DLvKVYIrR5QDkaMp2T9jmHWOY350AaCOtp3sHiR8ke6oTE2Pph/QRt4IGpI0/9OlOC9UGymPYZZ
 V9kNxnN+fwIpnHOWzrzWWogSxgiXViZOY+jxSICkkONwpIlPDK0NYC2+O4jSSRaTm7Tv0jF62k1
 prRKMb6gBN68zMJuqEUcG03QgCBiL9kBoCwpov1N+tz7EKkW1pf7hMC8wl0UgBVQE4o9HbcxNgH
 396JJAILS2c2NHBecEEEU2Hn8f1T8BSYw9i8kSsFkxUYMI7Iak84y0653B8+sJvEJClhtjw94If
 nN7CQsXkWQmElJTx7ywvoyf2wcadUGYpRDmEVjuVyBbVncjyzmW3aufyFzI9c7MSXU/APSPVCez
 aSvQrHyatWzFekvX3TSoxwnCVj0kmaY0rprs4Uc35rBn/67tkAOSCfs++1/10zmdEAqcO5x2a0T
 IAY+hMnPhrd0yYLskrnfs1+9zhF3aFsR9q8dD9rEVUVw+i9FXKcvXpP4AD7SNLeDYqMggqvcGQk
 6RvbjgcEGizAygA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX10THoGp830Ue
 hOW3DWhU2jK4kxZqwtYfbEr+2KmtSEGuCe4I/ETtKUDBlgmmw72suqXg+ghJZGGHNE/JqTAryg8
 Pbrwk4eKtALxm5x8XqP0qqA935AjgwhqmGwkQ3rT63SSD/3YLmpvueIKXHLn2Pvzn/FVDS131gF
 J5TaUlgXCeaRc3imX8VIOzmm5WURfb2p8I0PHpXcCHMKPCLKeau1gavuDJg5H25wVAhSy3hL4jR
 gXpdl6WcOuYI0LET2+Rcbhs1yiKa0eEZhI6nXRfBbC5HxCMzyTulBHEaXK2EqAsxfO9uNnDewKD
 r2mgo9jDfzBJbz0SMWeu5A4iGoOzwRZZB4/mnnlCV8LHBQYL8SiW5ML3q7OM7TlgbUk78rNEPAH
 HE1xgwcUvE0jQPpDVKn98I9erCWEFsaMrBssNCEJNdm778kKntICin0DlAEDoy9RzH4fPLpfV7+
 +yOAJ1Zv3ELbIzflQpA==
X-Proofpoint-ORIG-GUID: ORECFnNdLuskwGkv69G6pHGfrxev4465
X-Proofpoint-GUID: ORECFnNdLuskwGkv69G6pHGfrxev4465
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a7f542 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Hmb-lenyu1CM-5GwpyMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: 3B7131FD283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43549-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

OF_GPIO is automatically enabled on all OF systems. There's no need to
select it explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arc/plat-axs10x/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
index b9652c69d1b90e506f82b3b8c5be373c51246671..40f2a74d404ad9759ab9d6764c2496159eea045a 100644
--- a/arch/arc/plat-axs10x/Kconfig
+++ b/arch/arc/plat-axs10x/Kconfig
@@ -7,7 +7,6 @@ menuconfig ARC_PLAT_AXS10X
 	bool "Synopsys ARC AXS10x Software Development Platforms"
 	select DW_APB_ICTL
 	select GPIO_DWAPB
-	select OF_GPIO
 	select HAVE_PCI
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB

-- 
2.47.3


