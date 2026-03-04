Return-Path: <linux-pm+bounces-43542-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGjBN3nrp2lDlwAAu9opvQ
	(envelope-from <linux-pm+bounces-43542-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:21:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416151FC749
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736263019934
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BA386454;
	Wed,  4 Mar 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nm4m1xbB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJztzAx2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09037F74D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612217; cv=none; b=aLvk+UU3O53bl77oEUX0y/EA1LxZtr1Wmb6krM22uiAiwiA5EAiDgt37pb94Y7bUosntksgKeCYSPzZBm99MaWhs1d3HJQDl3nnep6ZReDU2BBEQ5ccKuCR+AP3ouiRicC9p0BvCE6Sbtwvigso9nnGWBfPG7/Ce9DbDn7pIuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612217; c=relaxed/simple;
	bh=/opHycjzCFnLxsHbSOMeid377lF3ptlX1EQZCIflr58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc1w3R+8XrOEaqYZaqjl4j+OXRhcFrdDaD25ku/bmdTR1znSyWUYXv356kYpitxuiWm+jFQYoDVgJR7lpETHBhjZEqENlz5PQEa2Hvibdu74WrTPAF1/v4eD4a4SOsQUkdCNcs7av9+lth/1+xh0PjtXeJgIzrp056VRMppAkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nm4m1xbB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJztzAx2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245Sstu3110945
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 08:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=; b=nm4m1xbB27ANg9dC
	CpysdbDg2A8oldcxHtHPfGzfi1uMPgK2bRX3h8P6+Om/07V7Vo4+DDrlus5BYb4I
	59miPAMx/4RnREI18QeObRJ6TOkdgC749EIGtXcPYM8SZyuG7zyJqDW7IqcrLO9g
	iUESJ4mqs4xdT+XwOE3rlIdOlConVbNoYntRnJfndYrZML1p9kuP+HEa6YbEMLIr
	DIpwSf6k5AqT4ETNqS0o0QXulsyY6L7oNQiWYeQ+RePYRLazp1ggP8w07RXs1yYb
	QC7TApuuhcKvONxbKOYxatm85NyjxIBGW8LQSV7LwJcSkK6EuMZfCvIBreim82Ie
	zadMRQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2aatv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 08:16:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c711251ac5so4141579485a.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772612215; x=1773217015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=;
        b=NJztzAx2MFayNZJWDxF+bGWJ4YxGE+v729SwXBtCKVjHLUz6/ttc2PUXCkUj6P4Dlv
         INbJ4ljLq+mlS/BA/c3XFMcdt87iW2cpEQNEvhIvr52K1OggPm9ftLziNgyXhWB4aVlI
         5poI/F0w3glSOLnJBx1GgR2ZEPHyS1qXOO/KdMjQ7U5vt6U2ZUPhSi0Mm9SfA5tnXVi8
         iQbE361lvZJ0a7aSx1pjZTm8Ao7Ds9E4owZp53nTof2BxB0h18NDGkcV6kxT67vdckou
         7l1/phyPeSDubTjYLrx6G0kHgeLg4zLP/MpeoiYrrxDk8ftKoTRhO9woGKgAB0ltlBOD
         o7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612215; x=1773217015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=;
        b=EgYDutBys2CG32X4w0Md+Rv+CcMvstFkhHrrckIwUrd7Y/GNhUdg6mTmg1a3UwCJDp
         uFrb4U82cJNgXnhNrRbgmmMSwJA+gt/O0xFWr4tz7wpcv/ofUtOgF4GN9hjDJoukN3w5
         QOOTGBWdxqomVAo/6aP34nKAEW84Bnhs3sMXpCQusJS6byQUe43KPYZgLvgoWgHZOwfL
         obJsTJFsfPJl5xaLOKwU2pIdYUzoZT6wqHZxZaDiSmhznumgDexnGkPoO+BQEq+zTuhQ
         3CHqcXZKQiLz978LJZZH9IblF1YBJywHdito4L5grEflgQH4v9YdpF32mWIt2XEa69/X
         uKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7UCl8zAqj45d6F9iljdRURGnFbzTNWLTWEgpd05C40G+SoOBaZDNqBLbmTeY6JpwRJtHuQ2qvhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyT7Xxb4VGEi7naAFFqMwTRmXCAYCGU1gQZrv0N/njHkG+Snh
	7FdVmZnMerkOZJkkP9I2F6oGndUos4BHU9MnXIym73pjAIWo/9e+5zEP3MyeKVCOhHz1uSvGw0g
	Y8zP1bGLStlWM+FHQ6YW6R4Iii6s32nX0WNV/2/zn6B+7AiHz6kGcaEnj5d0pAA==
X-Gm-Gg: ATEYQzyVeIOBoeuAxc9WOze53QdZR78i2S9hZZrbYcjR0QkFqbR5N6vR1Lktbaweqhh
	MQR4rEZJjPzR4NIFTi0ItrcWZwZMUHAk594Bww1NdV5LXX/bb0R69qSH7CA4GCo7jN+vGUERZFp
	g9WggbCQI/h4Tw5JeCpnCYIH34BoLmz+14NycpQySzgLlLvMaDotRBEsZ8McZgCdW6MKOKKM3ow
	o9FWsvByRGeH3Mjv7JUtaIK7IslgzmsDqYGo8UCgzPjXo8TiRqF3ssUalDLEBBp4LusfhvL+Yx9
	ljOm1Wzf0ZfgKIXa5bxA6h91De6vGs5EPaU0Jyqt2YGbv3b6Xwp37k4PJlQDhE+qkr9sYpVProX
	iaavRdbXqwZPJRw3UeQYMgGtak4M27fUzjiATM11TYA/rJblxNbY=
X-Received: by 2002:a05:620a:4410:b0:8cb:8251:3fe0 with SMTP id af79cd13be357-8cd5aefbb9fmr162489185a.24.1772612214750;
        Wed, 04 Mar 2026 00:16:54 -0800 (PST)
X-Received: by 2002:a05:620a:4410:b0:8cb:8251:3fe0 with SMTP id af79cd13be357-8cd5aefbb9fmr162486185a.24.1772612214248;
        Wed, 04 Mar 2026 00:16:54 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm16666429f8f.27.2026.03.04.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:16:53 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Fix device node reference leak in probe
Date: Wed,  4 Mar 2026 09:16:51 +0100
Message-ID: <177261220761.4483.11760077832525432450.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302-m2-v1-1-a6533e18aa69@gmail.com>
References: <20260302-m2-v1-1-a6533e18aa69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7ea77 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SUrkIAiDFwdAeyG8CjUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ymOkIm2_MBBWHoHmzVwy6sncmvLKwZ8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2MyBTYWx0ZWRfX7Kdmco8jA7FB
 SD0Drba2dxgxphl3WlsJvDWg24bGyjJfF8rxLOzJOETDpJv9zApFtzHkPprVvddSF67Ksefm6dl
 A1uqTNUDXvmthNT0ZEHeDDaJ58MsaFXIiKorNN3c8d83Nd2sbP5tkTgUMgGP/FnsfEMMLPU3GCR
 XGneFhkflwC3Qv8YMSfmlUOhsQCEZZd7vqKFh7wAhfT9vnmWNetMSFCW3nYBy2h+QQMCG+OBdQf
 hJcjJ5OdeZ4jWpd7Wn9uao2Ud83x2Z7nqU/WWmGAiQPyz9xC4UAyv7J18nHrRX9dSdIBID05WI8
 61pkQjO4wOqwJvZ5O02oGT0QzUKe26t+E4bxf8V9xQJMicBUfVcZBKraXniqB2bfREtA60YM/sA
 /3p60c8Oun5GWSkIFQ5WyVBHM6Ffia9yw9cLTNAg/Jnlq080o8GSBp6HiqliebFAzy7YsnNQvQ7
 kx40dJgHZHkZgCHUKcg==
X-Proofpoint-GUID: ymOkIm2_MBBWHoHmzVwy6sncmvLKwZ8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040063
X-Rspamd-Queue-Id: 416151FC749
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-43542-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Mon, 02 Mar 2026 22:31:44 +0800, Felix Gu wrote:
> In pwrseq_pcie_m2_probe(), ctx->of_node acquires an explicit reference
> to the device node using of_node_get(), but there is no corresponding
> of_node_put() in the driver's error handling paths or removal.
> 
> Since the ctx is tied to the lifecycle of the platform device, there
> is no need to hold an additional reference to the device's own of_node.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Fix device node reference leak in probe
      https://git.kernel.org/brgl/c/5c3daa5301693d2e5364483a3405649a0fdaed98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

