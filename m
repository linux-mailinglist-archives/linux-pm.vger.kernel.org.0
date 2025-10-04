Return-Path: <linux-pm+bounces-35713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E5BB89EE
	for <lists+linux-pm@lfdr.de>; Sat, 04 Oct 2025 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F12494E1222
	for <lists+linux-pm@lfdr.de>; Sat,  4 Oct 2025 06:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD1217F36;
	Sat,  4 Oct 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTL4R9Jf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F61BC3F
	for <linux-pm@vger.kernel.org>; Sat,  4 Oct 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558810; cv=none; b=e03dcaTov9PlrW9bqcIUX/3Wz8kfHzp2k3taT7roG4SgwmK3AHTku1TUeQJ+UM6k0tJACpjawTOY6BSDeigWbg+iNAGR50g2q0JnloLCW3ySnTMtND868XZemGIsMHz009cv7g8CTuongLhrIkCMl/FBeyt8ZCsVBwxXjMn9rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558810; c=relaxed/simple;
	bh=E4TpaqU2JrKdPWSIkXzozlfkEfDOp9hCavV8plMCWXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuX2qrt/nb0WuofVgC4N518uB+juedM3logne5gQTj3Yc71ua9IMD2jFEqPQMt8O6Zk8QEALnohr06xbvKQW7vxtFGn/saeV67KTxwTofos4CUcb+0iR+CxSWWzO+JoOmKNXYhj4DySvH4it7LirVX1bfr76VxQmq4slHT1a8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTL4R9Jf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5940M4nc027906
	for <linux-pm@vger.kernel.org>; Sat, 4 Oct 2025 06:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8m4k7jTFBedu+wLB0+uZwOmi
	JaNTVqtHpAOlLIi7cx4=; b=fTL4R9Jf0MrmZ6wcWUb2QoCkcsURGAbXIo6uUyFh
	z0CFCo3eqqzhyF1X+DX6pVXLRBY+VBGg61MzFXs5ocqPfVVdLPhzwuUAP3V8aaf9
	dpJ+PN29CC/zhpg4EaGdVDzCbtc/Dl5/vY2h5PHbLGzxce7lTHpMtjpkQIT/tGNM
	aEZO49h/OwzEgyGnyOjxynMXIpu3xdlCfN9No1vISuY8mz6hNKHnW8C+juPXmxzv
	99c8rVMIrRfBIDT679m5p7VZfOuc3AtvS2maeRkHvmkijY8NBpNwmDKFeZ1ySGmY
	+ShMlp201YvYmIhyC5ZYNa7B917jCdHISuaQJPMSzg3xxw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn0fqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 04 Oct 2025 06:20:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e1f265b8b5so67453711cf.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 23:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558807; x=1760163607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m4k7jTFBedu+wLB0+uZwOmiJaNTVqtHpAOlLIi7cx4=;
        b=Z+wZihuD4O+yPHkCo/Ip2rE3CJpUyE4wE5XbEdIo9EWXp08jPxJ79SjGayDNn+EQf4
         UYiUHWKmrcwXCWfvNpdavq53VSKU1ChhrJymqaXPrpcGTK+i9ILpyEtSYV9kFnoE28lw
         kCQTIgnbkqPXOewTgTTF7lrPjoKxplpplx2/m60ei1GkoyB169LS5BnNAKk+B1WeSZUA
         2Ca6DknEKdDwSXFPFn5A4zwBiErp4Stla66VJUu+R09aVUbiufaz1eV/OpKrNmINcnRP
         o+8fce1qF1FH9WM6h2NmCi2gep8nSqzBevDW80wF6TRNzLmsqTUvQ4uM6C3I7sSoH8h9
         qBrw==
X-Forwarded-Encrypted: i=1; AJvYcCVi+ylIDqvJIp9xwB8ocXvfonQeC8LPv/212ikkYYRM04pEArLVqNNe7hpPUVxdUPg6VN5Kf8hUpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8l/imhURSreIUzWc+MyEwEc5OyOejCAD4R/oZF09UKj233yCg
	hpr3sYhlaB1/yE52rI9ckh6Ul0CLsNJQuMj8Ta9Eigjdpg9cWMigIFdje3qsDnkU7xy/BtTqM9T
	MyH4tQsHOOZRuclGV4yNrQK5XhDjVXJ7eAIRY9rsoFRWa/4oO2H/wlnPFTbgw7w==
X-Gm-Gg: ASbGncsELuVMJSsTisFLt1T+Bpyqdi5GB0ERAQRtjzlLvFxw5JY2AyxmfVwuzomXP8O
	kFyOrfcqzDK/dTY2wEss1gocvpuENhY2lJQvDNd27PRJ1QXJapexi0XTfIoayNhfmH/20hDhadg
	Snnr9xu/ieUHIvKU2GypnTiE+Qd/Cui91RYzsHE0HoGEbYIwjOSMpJ8IJXA2Pr6INq1g5CWyiJr
	cz/inVs5zjydjwMdl4k5aQcxXGa9Rhm8xj4T1XoMce4D8YF76EGQ70zrafMa1ZHC9s0ssMpUgLe
	H6pQPuppgN/SrkztolTxicvIyxiNDp3EaRBPTQlqLp4jb+gTWw6WMVglExDZkMnO1Sp1p0WRIDL
	NulohK6tsX50fOZ3cpFiMyOX+B170pH3bMJFoq5bNFNf+aPLy57217s24ow==
X-Received: by 2002:ac8:5f96:0:b0:4dc:93cb:fdf6 with SMTP id d75a77b69052e-4e576ae681amr63138291cf.40.1759558807442;
        Fri, 03 Oct 2025 23:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGidBRK9vwwuPbw+sdHnG+JGdSaIpFRU9khv8BmL2+FlZ/ApkKjfg3yG1B7zJPyfdzHmKwUtQ==
X-Received: by 2002:ac8:5f96:0:b0:4dc:93cb:fdf6 with SMTP id d75a77b69052e-4e576ae681amr63138191cf.40.1759558806948;
        Fri, 03 Oct 2025 23:20:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm21486421fa.30.2025.10.03.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:20:06 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:20:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sa8775p: enable QoS
 configuration
Message-ID: <uscvhnjlqfppfq4gh3gkja3hww5ldyxprbetqzpfmb4753v2ek@76w6rck2r6gr>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-3-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX0w0pguITp49s
 qVR9e4bmmjzYc3qeNbxmOnl4GJlc2XcjD40abNIzBYWlsgde8ExNTx9+u++c5GOBp01vpSUW7ru
 HmS8iOCCJUptTiQtOy277By57r2HIG5+alOi2hQt6kq343yaAGzJjdFODMZrySIHu5U3zmX/KxN
 DF7TPBn6dwGrR/7VbeyFo9zByypvDW5roGg+sN+vsnw2FQ7QgUEk33N2rU9ofvARjkdBb7/31N2
 K9nPFmIjmBSkHaTqEaQRnmcIn40DsMIUj4IB4Sw7mgKFXBkbKTSys8w4JYSDUchBudB7sSwG+gA
 e762O2bXBM64AriyNiLrHSHbx3kxazQ2jFvRLmUCPrFR7pxUehqM2SnsPXZ4vS66slQnwVS4uU5
 00nEHd6DfQv+UDSlib/OndR86XaesQ==
X-Proofpoint-GUID: y4ny1I0s2ZIac2fm2mZw3CbxIpCtaB5X
X-Proofpoint-ORIG-GUID: y4ny1I0s2ZIac2fm2mZw3CbxIpCtaB5X
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e0bc98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=sR7M8zb89NgoQLAwK4gA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On Wed, Oct 01, 2025 at 01:03:43PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefinedi priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

