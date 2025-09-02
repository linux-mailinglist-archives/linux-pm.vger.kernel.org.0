Return-Path: <linux-pm+bounces-33657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30094B40B17
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D8E5E0EDF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC0338F22;
	Tue,  2 Sep 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J94iLqyw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6332BF49;
	Tue,  2 Sep 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831887; cv=none; b=V1S1hu5i/Q9DGzdwprS0I3fjvNAOGPYx7R7CsO05mEN2w8ErjVvz4HtCYO8cxaYK0B+9E8NubtAZLPKSjt9iVMDKeX5+/IQJNUxOUkLjxylX4vZqn9q6iUGZYiM6Tc12ZN1FSUuUu08smrdskICZBcUuXB33dOTMuGXDn6tZtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831887; c=relaxed/simple;
	bh=lIbE/1Aoqm4Jo61r+hMyagD0H71z3BwYFHkhUMeX9zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWewmGiZoVi4M9gN+87wBMskL9NJvlp2S2xAgIWJ99O2iS2MmEBboBz281kXQrPvjrK+w1Qm5atkECA6TpEbBYIplxo4/QX/GBRvA6jE9yw+GVKU9YyZle2o4xNwOUnAXurytuIUvLKgbPwsdThdobxJrOUJtYpz1MA8niMXel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J94iLqyw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so3196563e87.1;
        Tue, 02 Sep 2025 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756831884; x=1757436684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIbE/1Aoqm4Jo61r+hMyagD0H71z3BwYFHkhUMeX9zQ=;
        b=J94iLqyw4Y9xEGaAYce2nV2xlgusHZkx3vXA+gWWWEFukU2iVPAffTfEsX+a9Gohvp
         Qm/+aOHNEQgqJEqnZyyQwHswH5ZCqGEjtjUZKjKJ9Zw5AUNcXKsPNW14DVCD2aAaFdkr
         K+tvWRCFr+ROgw9u4BhY2v0FRZRN/cn+n20c+CMOltfhGI6obIayE3JXR400KngOFGQS
         OkGXWhEkOuB+u32JXdpT38cgrpbTLDCmzrXB6jQejYfqQiMbonGw8R8DHVKaFFg6TLUp
         GJP+yymOel3pDRcez8bnBEyhtLtxPBPtjtVj4hd+fIb/pDJK8FyL306zb6nFbMhr79m9
         bQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831884; x=1757436684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIbE/1Aoqm4Jo61r+hMyagD0H71z3BwYFHkhUMeX9zQ=;
        b=rsZpnUSRNTe8Y4SB7TdhHqoA/HbTpKGnoTBDwoy0lyGDHk5kUe12caJZITmMq07XWc
         xa0WnWFmjCfec4e0MttPUs9XJWR6CpT7eEElrwCfHD+iyKpy6jXt5s5NUu/jfOvnROr/
         n1ekf7RQpi2710Bv+I6Dx47dAkUW1CyyvabA/VEN2p1g2ZGC9GAFN+Hm2Nxmf01mE14B
         X2VnHgApj0ysYKdwVrg39AXHAWNnL2EGNKrFZypw9MZUTEOkDFcWTv6mMxStb5pYPiu8
         iaSk65bWhvdc9BfJ43D1vLQ2qMK23gOUOgUtOJ0OdrN5G4pEDl5mjWK16mdmx/Hynhl4
         V3jA==
X-Forwarded-Encrypted: i=1; AJvYcCV1l67AkcN8T1D7qtyC1T8tKkBgiX7qwS3vIYU2ut069kfQFzDhfXf1Bz6dAVe2uAz1OaZ8BeBkMDt+@vger.kernel.org, AJvYcCV7o3GvJkhOArEqfXduCVEdQB5pvSEmCcnGdAHN2BUJL8eY9ArD9CTRg9lqxRW36peahp/a4gQZQWvSrQo=@vger.kernel.org, AJvYcCWYQOMSmiH/Yv60T6NsWj1c5maZ9fPR0JI4odxV3ZY5e/muOcSmOC9vNruWWGLmTpoH2tzdxYR2pZiJ8IAR@vger.kernel.org, AJvYcCXt1meYzWYxfW8K6sDzV13FPyQvvIXAphyLoUog2pJb0E9LK3U1V83jrqbr0+5d8hSqCJmAvcCdCFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+RF5QNAypOGrouilOVevSUH/Yze/zy4rkKpgMVo8JHu7eqUt
	z9S8eF0PfO/rGQXAnFzXKk6lUMA/LTeAeRJmP1gJUcKwe5ZRsow1C26ZwUMveIPtPC16v1pNhpx
	vSHFThnAxXSvnk/zh3GxsKh1tbWkkeQU=
X-Gm-Gg: ASbGncuaaT/AeTqEsaQ3Mc7yIBH+mg98TjIZTsmGEBq30MrVQ7gJK+vb0t8PyjKVQEj
	LFo9ZNydQrto7wliim7gbBFZsVd30fnaBg+PE7nVnQT8LS4VsNMNcNCQxNPHUIMKKuCrBtDCSCh
	DLUn17VAJnSpaONq/fyp6A9haZxlH++BrfG54DbcRFVMsauA5yiQzyfKo+dUZWTcHRbNMax4riX
	EVYrH8=
X-Google-Smtp-Source: AGHT+IEChupoSD+9y1BXRKDMPiEUXXbCpO5UGzRaQ31kMw0aqronmTkKMHnTV+chIoZjNTqShh3rv+672NAMniN+Xf8=
X-Received: by 2002:a05:6512:448e:b0:55f:645a:7146 with SMTP id
 2adb3069b0e04-55f70968d9dmr3182922e87.46.1756831883361; Tue, 02 Sep 2025
 09:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com> <20250902-glittering-toucan-of-feminism-95fd9f@kuoka>
In-Reply-To: <20250902-glittering-toucan-of-feminism-95fd9f@kuoka>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 2 Sep 2025 11:51:11 -0500
X-Gm-Features: Ac12FXwYWaxQZ7C2fCm_0oyX8iaPoPZ0amPC4H_SBlrNsaYfoKZf6cjuvVA16aA
Message-ID: <CALHNRZ_CNvq_srzBZytrO6ZReg81Z6g_-Sa+=26kBEHx_c8WQA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:23=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Sun, Aug 31, 2025 at 10:33:48PM -0500, Aaron Kling wrote:
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
>
> Three different subsystems and no single explanation of dependencies and
> how this can be merged.

The only cross-subsystem hard dependency is that patches 5 and 6 need
patches 1 and 2 respectively. Patch 5 logically needs patch 3 to
operate as expected, but there should not be compile compile or probe
failures if those are out of order. How would you expect this to be
presented in a cover letter?

Aaron

