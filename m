Return-Path: <linux-pm+bounces-43559-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ0GOqb2p2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43559-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:08:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6A1FD3EC
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 591B93058F29
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824039B966;
	Wed,  4 Mar 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUvkTtYI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZkJPOMFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A839B94E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615022; cv=none; b=GRScSR0p5J2i6d+4upIQ0Czu7FN21T/8lmk1GiGutuyiDM+ZwzbGQtj0jrSYK01VIpE6PtMdN4iQUtsSFzFjPt8kduXpD/xsU/c/iKtsdWX/BKyM5438Qv9uimrVeADeYSABcq6MSkVu2+aPxtXO4u2F19ZR2s05zlVcLE8hQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615022; c=relaxed/simple;
	bh=F9ytT2vvzgyeiU8WNksbCaFX6Hz61vWU6GkVZMPweL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8oAr8b61rqatQImFKXsCD3RmcR3SIp26qIh8No8CzjTmn8D+q/XB+afYQyuc4Xv2tZOmj5pW1zQibqMqFSh0+DamDu/UyC2ooG8t+vv7e9cVD7y3Ggc/Ie8irFVYgAAi0MntGxhNgQo7ZFVDqjPPgj8t2+YV+5AmxVPvTf3hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HUvkTtYI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZkJPOMFl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SSws3110377
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 09:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=; b=HUvkTtYIGHCF46cT
	vzFc6J6pDnXt8HmS67vhxuF7vL53WUanXgs0NbH+VI5EVRDnySVd8Y7UZWIL+2+X
	6esk1LCKZeg8BlKjca74TYxulLvKMKzwRHuf0pTLbqexTMJQjJb2tyrkS3HJkYa1
	OZagmawkFeI4w93zRbxy0aCpFx+H0vJhb+sqvrcP3K/oymnAd1Ce/IZ9qU+XxKgC
	0HknP2Oz/5e6O9DS9aizV3ROR4E1dvMIN2m/MqCqdGgBqiDPHCRy0j72cYIlQvkc
	NWZF3vdPFc2nAHBFbiJV/d6bP48ch+3E/q8AkJYdRYjJzqWtXUd5yQcEKq6u7sVU
	yGBMZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2agwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 09:03:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71156fe09so4094886685a.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772615020; x=1773219820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=;
        b=ZkJPOMFlKJ8NG+AP4dskzwGg94kZgQ/AaCSZ/q33mjLhbpYFCRmH9M7RHBHepwmPHv
         I8FMw7ZBVVa3cY5eqzGO3cpG8dN1v6hu/No4OaRdWGp8UoyigvMOFb1LxhWYYdE332E3
         MlYuXUat4uo1Gs0EbPp6uXLbX59vlrR5dg58L3XWeSHXvqfR0kr80dKlzSzFc9Ly/5Ge
         ywCYAYdBPjAMf4q9OCO0ZxIB2Pc04Xhf5MtssTWhIkInnoyqB8cxOFIUQgELZyApUAKA
         +9lZg43KAhM889HiE88QZ6YkK8XxOtP0X7zrAco9eRiwXzHr0BgyONI+TeTrF9RraiAE
         /p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615020; x=1773219820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=;
        b=euMK3kR9jYEwRXzDceSvRoS3avogDXTZd6vJuHajZAqduUFPtItf5frO0U5Al8TVfj
         aLYVhegighPw2OmjAVfCKtfiFMN0LZ7VS5K+czUzYCMtgh2CDM6B3QBLr1bQuAchuHf6
         5F7ePPN7WAVlDUiXfANwoY8iRDpQhMS1o239JNyArF3qVSLA/ow3iXbmakAIJSWaaQyP
         5n6rEsrvk/yK4NbntwEupWvl8EelUOiDXrcxKR9PC42D4IUBeMYticJ7a6BFVCDVi6Sq
         ql/USiWFP634591I04thT3O6Z2mhu/44VFxIBdXeBXaHAhNCw/s7Ky2/n9o7kGs/OqkF
         QWxA==
X-Forwarded-Encrypted: i=1; AJvYcCUBSgSh8bfnCZzH9MksGO2jOetVZnYK/KgCVeyJjhTzfsceoUWwX5eLjo3Wav2PHL+YVs2LCWRU8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3tkYybMaQ8ywjmnoRJpDdALb0PY062cQhFyTj6zihPM4H0D2
	lkz8exRcmF9nVjl9iT7MMo2ocrNzLfLZGh7s4IYFmPswsxSNeyZj4AfhXgaMh3TGQI41qW+1qSF
	JVZn7YEpHd16NR+mgwOuBGubpWq1z9q63dAYWqf7VxLSauyeGjrBQ5KN4deu0hQ==
X-Gm-Gg: ATEYQzxtSePpirqLssFCx0WgSCiTq78srcSiGezgOkW2WS7BNhIymUuKYzcF9zbKk0B
	RJcpEaDqxFcDtmtjoYKhCtFrHK7skTpZw3tRJOmEpGEBg5bh+uHjvzxqYMxTtSLuYD6rsedjeEe
	3hpphtp3I1QB5FmYdjHC4YYgmdsrK8hXxe5zKdzCJSOM6UtWNk45+0QByW4G+67bhkDxYYmMwX1
	QGDFtCRouA3PCRyFo/oh3hu9A5wTJh62zsLyOmMpG7l7GUYIry9Ie+v2AwhA9F0FtmJjHEL4QIy
	GJ+VgdjdwW3XCC0+IcIbH69PeWElHQIu0GhnVTKHDOcilE1ARLfFGf2kvrMg5gbC2teJjmezLYe
	oUXNO3tN2vAppH/sXvoQ7IMnIqzyeWfurOz9IqezUVzauUvg91JEs
X-Received: by 2002:a05:620a:3949:b0:8ca:3854:8110 with SMTP id af79cd13be357-8cd5afc0c38mr159219485a.72.1772615019771;
        Wed, 04 Mar 2026 01:03:39 -0800 (PST)
X-Received: by 2002:a05:620a:3949:b0:8ca:3854:8110 with SMTP id af79cd13be357-8cd5afc0c38mr159216885a.72.1772615019300;
        Wed, 04 Mar 2026 01:03:39 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:33 +0100
Subject: [PATCH 12/14] staging: media: max96712: drop unneeded dependency
 on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-12-d597916e79e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=833;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=F9ytT2vvzgyeiU8WNksbCaFX6Hz61vWU6GkVZMPweL4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/U0YPpmr6EkC/Xcj5u6S5E3hZ52MCZJ0xQCq
 e6KcvDJUhqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1NAAKCRAFnS7L/zaE
 w6ghEACtFFABHdrYTiZk0+F+HrOgj/2q9yn3zJKW2IUhc5ip11gsNxaZvRGYVoD1y9TrvFt77ji
 PFlWiBoM2qd2vxnADhudDyeyhkhNYjJeDPoyAS5BMkPEjo34LXOvRTt2jdNLcS0Yggitruyx3rl
 tEMtfMKolvomXC1gG17ZNj7PMDSOq+VsU9spkQ5TnrTJBHuLzzCCb20Glo7TFGAKZmQ9F/s0b19
 CUq+HEdABlAp8r2rt5877/AjCvFT2Y5YZvCPq8kKs3IF/vYAOnCW5j2f5VAzI9q7Ryf3HLlcbK5
 UJCVo6O1bKbH/P8T/DiGfR6yISzdNn12TXv6iYwwd0f8GUzMVVWU4l/VSepOfpcMY0K3ztQqHyH
 OJbQaN9cutXu/UrO0GsSwbu1XiTOcjKwXvZUgFMQyIs9mLHmwogfAqtgtlcKK0dfWKBTFtMk0R5
 Ya4MZuCMDiHuGEpWbZafXSaoIsowZpMZLWWMyck9cGXExUWFEtZza+r21drHqGw0M2nsB+Rdfuu
 JCtHW3W8cUNbtFfx/qtGTP4U1lvK2greeMzLTCgxtApLXz2h0CYhpOv1ETFzQr5gf0Ef9O6klZ1
 ifje4A7FNyS1+Sgh1NX897ZJ1aNIEh1ABIBtSAc4rvOd/HV+rMhsfL+4AhwtauXWv2W4fdZB9GW
 TlHYCNXye0s/o2w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7f56c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lbdJfbWXG8Zdtkr9XfcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: eDAH7upcw1yVf0gRmh_WrI5O2YSgJYq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX/nQAcdpBr5ga
 9GqXbT8tQoeyQXkw/q7AFz0tHTSdYcjnxpeNViX0+hb2V3MysabwJi+araBDjQd9T9ffwbLq7zj
 kJUPKtRwmc5+a3U5QHctQO72zw0ahx4nncNmfJeCCNJDjYJrKL7DT5pZfewCKzCDBNqj1cVG4Ri
 q78ZtepjUQ92Tkyf36gPzCE6GfNQGoyedUaKlu4Jb/j9k9+VRqJx5/JED8/P242AQyyk7AIEb4V
 CJES29F4nQ/uCURSClaCipetpcojqz2P7vv8hCDLHVMP4sHnG0XnkC5bKtNEJZLNK9uMwrbdDDl
 DU9vjuYrch3ZFrT91P7fR0TxoMFfJw3yHYKvMoNam9KHew7maHJPtx9KkTZSPlYUezOdC8pkgoS
 WvxpskTr4Q67WlzUOd5ZJ1JMKDjFBRZpUeiUmY/61pkqEE+lTmciFPrbfBqK9Q9eS633OntCjKb
 tIxRGUW2qMuQpQE4Sww==
X-Proofpoint-GUID: eDAH7upcw1yVf0gRmh_WrI5O2YSgJYq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: 3AE6A1FD3EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43559-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
 drivers/staging/media/max96712/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/max96712/Kconfig b/drivers/staging/media/max96712/Kconfig
index 117fadf81bd086cc3e5e95210503000d9e4d8738..93a2d583e90ddb2b797c5167a6d3373836e88126 100644
--- a/drivers/staging/media/max96712/Kconfig
+++ b/drivers/staging/media/max96712/Kconfig
@@ -2,7 +2,6 @@
 config VIDEO_MAX96712
 	tristate "Maxim MAX96712 Quad GMSL2 Deserializer support"
 	depends on I2C
-	depends on OF_GPIO
 	depends on VIDEO_DEV
 	select V4L2_FWNODE
 	select VIDEO_V4L2_SUBDEV_API

-- 
2.47.3


