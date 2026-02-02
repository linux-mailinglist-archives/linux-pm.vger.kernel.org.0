Return-Path: <linux-pm+bounces-41914-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAinAsjJgGl3AgMAu9opvQ
	(envelope-from <linux-pm+bounces-41914-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 16:59:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAECE890
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC613031801
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238A252292;
	Mon,  2 Feb 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+CCQgp8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3gmAVDv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9F45948
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047490; cv=pass; b=KTWihX3RiiYT6wlIgq0olDazEK1HYq0t4Qj1xI0cYqPUjFxL1t/TTzwSj67P3F+DwPpqtnzz/R5xpRywed8md9iei4xQDVABsuAj+961bNzUDW87qOx+lQfk6ABoL3hLyIGCPbKNIOHGOoJ21+o/aXAdvd99xk8yume9MkglDDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047490; c=relaxed/simple;
	bh=T4gCvEK5pOrZp04yFKhri9JQ2qyg1XBt9hVS+X7ctlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW7ZlyWM+4Vz9xZc5emJV+4FNRB5QCtNQnqYqqg34WV99DTt2rv8qnOmyw/Zs4MyGETcvXoIifiqoTvhhNqjtJHV0/AAsBolXwwZnegDuIBroe6MCaxMUSus/up7ZLNckUD1Il7SdmRcFUZ8I1ktkolnNkKe3tEX8QVm+UVwH4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+CCQgp8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3gmAVDv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612EK62k1603107
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 15:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7yDh+JC7Z+2RBqZUUP8nJKY2
	Ywl628bcHYB1vTz3mFc=; b=K+CCQgp8nA15ZURa5/1084YIeiGw3MpFG3485Jyz
	OEBNk8BOLECS0x7hNAtxhic3vtEv75iaR/KvhrMCkrYAK/GxLQ9gbCMmC6XROraX
	vFuuBIW4wO2ny5k/p4ZJsnT9fIwfIwEYYHaqkVwjcC0fR4fJyN7f1iaFIjqnbdxC
	a7u35IRUu0kaAIreKB/5vf6DLyb9bE2J6clBHYkPhVMd9hsdGlUq2uAS1dnhA6Q5
	qifjSpkvSqLg2C61Ir35GSXM3dBzTdAPQx+y9wmvQ3dzeMTV3ELuthvFpiSVpQC6
	qkqyGHce17ZBpqEzWgWZ29zoYHQ6FAUvPSQKyBhKM1i64Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1kq5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 15:51:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso4808363a91.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 07:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770047488; cv=none;
        d=google.com; s=arc-20240605;
        b=j3v/wD1pnKmFd8m+5obvM5PA8kGUPtWYV7dap6DOwvyjrhsVL2ztxHVYk080Ngq3dT
         VD/G1C0aTW8xixnnocTNDAtdQvBxtOR/js4gZSlJIsaCiYgm3SsIGUpbc0zJ3MzDyfca
         mwf2B161a0GeWoKF/BIbVyMW98Johj+Vs6zyVHBeC5V+fuWk1rCZdinLlLG7U1wdm16p
         4fhP8e2FnB7DniamAmXfnHIwUYPc1HKUwsdqevx/adn3u7+mt+ymtI/UWGOzSXhlBHLb
         fHAs0VUlMGHYIbYLd4HSA/cYRY8lQa3KqJMdaJ702GZzMvtLestdGCQlrs7E0+I7Pwqm
         ISpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7yDh+JC7Z+2RBqZUUP8nJKY2Ywl628bcHYB1vTz3mFc=;
        fh=1e9oyaOcAbLsSyDq/aATgarUFqF55O7W714YNne1xrg=;
        b=CBid1DMPUVGOvCcpVxbVfHuL8iq1gBMm2rVJUxrzsZt9AScLwb9+z2hpsdbRmphVqK
         KzT49RJYf94iopde5RP1Da1YsEbcRoGDSMxWthrMORU/u8ec/1c1F+bWBF5CFEzkosFW
         Nw7vQRdXzqX8BxgT8aEjY5QNl6n96ECPXPKyXN5gnkjx1+Vq1ztKYZbVyOny/JOsq/OZ
         kAPko0jXzPOsmW3508JzIcecEQw7URtNNqoHTzKYlB3CP+dy/bzWhlMzGxxAdCTAWuhv
         73r61R/cNzHVzcrYqlVTXQA2yYs3Eq334Nog2YiOnHjqVgzWYgsSMpSF+ME4wCbYO+H1
         qzHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770047488; x=1770652288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7yDh+JC7Z+2RBqZUUP8nJKY2Ywl628bcHYB1vTz3mFc=;
        b=P3gmAVDv4mm6U2080KcMNIt9HkiTYhxjF3rAWfCl0Bva5dn6SZD/1WRxTqm3DZWp7D
         xoZ70AnLX7TUVV7RiHB47i8MWrp0EG3MbNhwd2MtYOBO4zKW/5kH4Hsw4Oz4dHOR2B/s
         zgDLVdI1fsqWpa/SGsgTBwnHNHPsO0UBoZjJLDR7Ug+/PzLFTTz5vsMMVkv4tLFknTKS
         XAqV/wL+en1gYrRGmBznxJB760Wln4/ZiLgqz327tTxQBeVJShmvauaYC9DtnkdHfbiX
         BkIUSIZhexy7FXW12bpBDfcH7C5Td0dK5crGWtz2MdYM1PpJfCKrtaJ3Rbf5ASdcj0pN
         Npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047488; x=1770652288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yDh+JC7Z+2RBqZUUP8nJKY2Ywl628bcHYB1vTz3mFc=;
        b=jP40hTo4iOe1lPma7xGj0Z8Zh5Srj68No5/BhCnSc4yVfDQo+tXX3dmMLYFB4sq4bW
         6TDcbo5lubR2WfFxiACnoXgRed7sphTmdP9SOgjyaUtfGU1IUHaEHBbw2beQj+6QImv3
         YtLfNaHomuIV1ilh2PeuybGnod9pj+vlAytco+NDAvl2O9tKWDn5byCQ3YMySVegcstb
         M7dyH3GEq0MPdkaE+I6B5/JGGbvSO4OvW4jEmMwicz21j86HmKgMk5ZhNWHqjP98nnh0
         7rpj0l8XTmmZSLyxCOEfC8ImDl6M+hdFSS5vvBflJ7PPZJ7JCOryDaQ7o9amoF+3oYyR
         Idog==
X-Forwarded-Encrypted: i=1; AJvYcCWmC8BwM7IS8q03uAqRJLxC7V37GxXFOuRMQNaXAptqwKnrmRr2Q2R4l6Keyhpoa8UA9YGdgITA7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X7L3A5Adv9D2UDqtdYf8X+Ba6DvWCzUXLOTer4iN15XEhHBu
	qvqzByW3KayPbD6ii628rGFWSzOrZElF1rDK1no1oTmygnbmxg+zw9nShN9B6E0FcPTUAulanEu
	Y2TBtj6lZmwhMsW7xIJf+gdpdc8OqcdY984odNEhgWOBSactuPYCvQJSqq+92AAj+WS5V8LycUY
	6zYh+0G7WONEMXqo4Xj1TJ/XNx3q47dBU5tmx6
X-Gm-Gg: AZuq6aLYmOxnlUeO7fPugFBmLJZGovvX4kWy0Y/qR4glSnezH5aTkLVM6Ep7YuZq74O
	Z6op0twnPx9kdnWilF/9v8w0ZKczn/XhJa2wv+qBjVXFoYQBGptL3Htijb8TqngMIg4zo0KF483
	UsHz7J0FOapK0jD34W7xHwL//J9EEwW0rqE3jFI00QcTVa6bWkq+cIURVUOpbawzHoeJ6bHMbRG
	jFDdKJpiapPgSBDPXrUHs/P8Tc=
X-Received: by 2002:a17:90a:e708:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-3543b2e008emr10839044a91.3.1770047488053;
        Mon, 02 Feb 2026 07:51:28 -0800 (PST)
X-Received: by 2002:a17:90a:e708:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-3543b2e008emr10839011a91.3.1770047487529; Mon, 02 Feb 2026
 07:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <CAPDyKFoNX087ZhLkQ_n8-42WNQcL06noSuPJPDG87y0andVdNg@mail.gmail.com>
In-Reply-To: <CAPDyKFoNX087ZhLkQ_n8-42WNQcL06noSuPJPDG87y0andVdNg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 17:51:16 +0200
X-Gm-Features: AZwV_Qi2e1xUlq06PRab_j4QBJgokhNft9ud38gaUZCSMyia8nonVRqW7NIgfHI
Message-ID: <CAO9ioeXkhxjghtGVGsOH=1hwC5FvS_4LEXt3hmAEuAbwVjct3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] media: qcom: iris/venus: fix power domain handling
 on SM8250
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: dmO7GyFLGvdHbie8lWISBk-tW3DfmP8r
X-Proofpoint-ORIG-GUID: dmO7GyFLGvdHbie8lWISBk-tW3DfmP8r
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=6980c800 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=2dp1CtdQIJBwMkjZU4MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyNSBTYWx0ZWRfX8D4+rkxpIL++
 GBqzabUAWUun+5sWryWJLrYpjj7HpYS4TLWzlu67I16MbC6M50t70LKSJgEramWw4K2iuV+VIxb
 2PfWX3tlX+xEXrSRueNVYnWGZTDFuJGYIgSrCGFXC6o/K7Y7b0oH7tRPIPNEUXlJz2Pi3yHes9A
 oI9wcSyyGoFntJoU7B5Nr3cHDQH5MohkUGVXt0ZjFGMEZLrRYeRMyAKYeE0EIyZE2rUhXxRbqGQ
 tbCuYQ7DP02+f38cC/9iLBkrCgcuN8zGdL9MXqmMfwCAegyFdghl+HgamlHOJKQOYmw/0fGA/IK
 fWA1fFITcIYvo/jD27Pmm54hPQE7wKduJFLRZL0T/T9mq5E+HfsdmYZKPpyg2RuHg/6AaaQ+EAz
 UpAnSP3ecbpICQDzwaCYdqj7XjzF7SMbF3WRHXXggYGZT+4PuV9mFx997CquI0yESUrn7nJw8iJ
 nqL7qFgUCW/Ncc7zrIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41914-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim]
X-Rspamd-Queue-Id: 53CAECE890
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 at 16:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 1 Feb 2026 at 11:49, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > As pointed out by Konrad during the review of SM8350 / SC8280XP
> > patchset, Iris aka Venus description has several flows. It doesn't scale
> > MMCX, the frequencies in the OPP table are wrong, etc.
> >
> > Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
> > stopping it from being overclocked).
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> Do you want me to pick up patch2 for v7.0 - or what do you suggest at
> this point?

I'd prefer it if it is picked through the immutable tag/branch.

>
> Kind regards
> Uffe
>
>
> > ---
> > Changes in v2:
> > - Fixed example in the new sm8250-videocc schema
> > - Link to v1: https://lore.kernel.org/r/20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com
> >
> > ---
> > Dmitry Baryshkov (8):
> >       dt-bindings: clock: qcom,sm8250-videocc: account for the MX domain
> >       pmdomain: de-constify fields struct dev_pm_domain_attach_data
> >       media: dt-bindings: qcom,sm8250-venus: sort out power domains
> >       media: iris: scale MMCX power domain on SM8250
> >       media: venus: scale MMCX power domain on SM8250
> >       arm64: dts: qcom: sm8250: add MX power domain to the video CC
> >       arm64: dts: qcom: sort out Iris power domains
> >       arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
> >
> >  .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
> >  .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
> >  .../bindings/media/qcom,sm8250-venus.yaml          | 10 +--
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi               | 42 +++++++----
> >  .../media/platform/qcom/iris/iris_platform_gen1.c  |  2 +-
> >  drivers/media/platform/qcom/iris/iris_probe.c      |  7 ++
> >  drivers/media/platform/qcom/venus/core.c           |  7 +-
> >  drivers/media/platform/qcom/venus/core.h           |  1 +
> >  drivers/media/platform/qcom/venus/pm_helpers.c     |  8 +-
> >  include/linux/pm_domain.h                          |  4 +-
> >  10 files changed, 140 insertions(+), 46 deletions(-)
> > ---
> > base-commit: 44ef70faf71468e0ae4bdb782a6d43f0614b8ffa
> > change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >



-- 
With best wishes
Dmitry

