Return-Path: <linux-pm+bounces-36775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2FC05A58
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9C4E643B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2E30EF8B;
	Fri, 24 Oct 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3aw87uT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2D242D93
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302680; cv=none; b=k6D9oLevzMEfaNBGSIGnJ51M3YnEDTHRaY73glhAavNxPBtxnpwPpbx7WNFi0eKK15Soh1Mt5K5KQQEYAs93x/nYR00IGE7AyqOMpKDVUABWsvz/+COj0XaeCV61f0d/NDnyp9EOsUoW27rc0htGAqAoFQaYMwHetLfJc4+Ef2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302680; c=relaxed/simple;
	bh=jNa/J7SUUBl35Onjepv+If+zX8838Xw+hVVHMSn9p7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=has/8v9Mpu65K1XVOKqDMHkEm6nRdq3i0cH05bfXJDueaWMq6Nupnxu8zK0r+7BbEJebP2UEwnVsOQSYKqGxm3pxScEhYM14tNTd7Cw/4l/38aVbmEz/JwgNG08eD3a6466/UsFsX87YmTZBF2QGdWl6V85ZnASd0Fb2TrbWnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3aw87uT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7817c2d909cso21555487b3.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761302676; x=1761907476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDrc6GQPhYnDILV4Yve5gdN5tbHzw4YDRq3NBsINCC4=;
        b=J3aw87uTECp5NSvsZCBWtjurBiKlmfvx5T21KVLpzsteszqyiTY4oqLKYezHo85YY7
         FkaFPIrYsVSY3V2nD3wSccTNqGzUcc/KXz1qtOkfK84tZA4bTAyhwuwHaxxdsjgHtf94
         GuC3yXpqGnFVdjJ0a4KLy2s/EquDS1zkfbTsm2VLVp7RC1NuAXlaAqM0SJAiPfoq6Pxt
         iYGcrPaHti+AZcUM9GXXD6CF3kDaiRytKCkc/sFRAMjM7WltYNEsM68QetGEP+nMggj7
         +41wzhL1gwLNGasspvWiWRmyffqbLCzsNGQzyRlwrOhnoEzhdEot84baZ6mwnoaPkKpf
         emDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302676; x=1761907476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDrc6GQPhYnDILV4Yve5gdN5tbHzw4YDRq3NBsINCC4=;
        b=Br15x6uUdUkbFU5CYluiX5TWkcOArDcJNHK/mC5vONEUFrhlq+u1waXXUNU3lvclnb
         tiRSod/Qjf5/APwxvoyt6M4CsbZ2zHJyUrGdnzEJSKH/qGjVfJiXl26LeZa9Hi5Sk36s
         A/ypBBZoEW0gu0i0/2BTo+6GIufD/Igy3aSCsHHfcoFNclaTnbXR8DcJoCPhnnIdrZFw
         dtnVKDVKCJYI11F4How6Yr4qd+DNUdHi3jdPpUCHsjlX7I4jVN/W+CC/7+fBxT8SVZA5
         eCFu4x8yo4bGlMX3irTdhYNELLS5s0eG+pgTnxlg/BFNr5K96+5MU7gccZNinYA6tSRL
         CxPA==
X-Forwarded-Encrypted: i=1; AJvYcCW09mjVgpOn7K1cx84yzbwGBxSrINfOOVrUDRvb16M/T13cdqLl2dnWGjPpg6poPlPn4IRT8zr/Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAtXwOznEvbwjpcr/3q037ComMihc/wmsDkWlP46dDd3Kpggb
	//Q00MnboEJKE4IcSiIZjcmwfkJjj9A7NVPrgI1445ppBBxBhadU6MqoOMk1yhUnDuosEWA+Fc5
	i4SqjAhRKwMT6OYfTtEzfwupnE6wBVtkO09FGEDIZ3w==
X-Gm-Gg: ASbGncvpz3QuK8E+kBJxGLLSQddAFn+ihCokiyFUsTVSlgLZyU91sslf7ix5g1dI7Mv
	0FXvApFNq/WY0kvZEdlWd703VnMDG1M5eNwCmopHRGCIuaKBYiV//usaxSNPnZsBeC0MOmSKiNa
	QMSBvqHRGLWNZ5EEtOThQW2ubyGaWGmsV4+T3Pgr/3pYg3Mi1qo+TvlUfdjme8oQcseFwH7tZ5Y
	qDXhKLHqqlIcMKg3wJ0JVmpIBq4wv5Mz6Rzp0pUw0wcNzC4cyJqZ4VVLLl+DRHMVvWLurUZ
X-Google-Smtp-Source: AGHT+IEk162CNV/HTeTP+EbQADVSjJepjQR6mTG44kaaL46hSa5PPLNcwyV02Tna+/k0FyPQLkha7E/815z4TlLX2p4=
X-Received: by 2002:a05:690c:3203:b0:784:180e:fd49 with SMTP id
 00721157ae682-784180f0a97mr412861637b3.5.1761302676319; Fri, 24 Oct 2025
 03:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <CAPDyKFprP1d-9Ojwz7QaVBbdFumPmRoVnifrP8v+eL6FHR3Unw@mail.gmail.com> <7acba50b-8c1e-4509-8100-3a65467d2d87@oss.qualcomm.com>
In-Reply-To: <7acba50b-8c1e-4509-8100-3a65467d2d87@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 24 Oct 2025 12:44:00 +0200
X-Gm-Features: AS18NWAv-FONlFrX1gjqXCW9VKk88FoqVyIeaznNcXjkVlZGoJBK2Lh8mAGu73k
Message-ID: <CAPDyKFqVKWCApVFjYpgXa2x3N9F7O1bGBBPz0JfNrWBYtg=M0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, tony.luck@intel.com, reinette.chatre@intel.com, 
	Dave.Martin@arm.com, james.morse@arm.com, amit.kucheria@linaro.org, 
	christian.loehle@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Oct 2025 at 10:40, Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 10/23/2025 7:03 PM, Ulf Hansson wrote:
> > On Mon, 21 Jul 2025 at 14:41, Zhongqiu Han <quic_zhonhan@quicinc.com> w=
rote:
> >>
> >> Hi all,
> >>
> >> This patch series introduces support for CPU affinity-based latency
> >> constraints in the PM QoS framework. The motivation is to allow
> >> finer-grained power management by enabling latency QoS requests to tar=
get
> >> specific CPUs, rather than applying system-wide constraints.
> >>
> >> The current PM QoS framework supports global and per-device CPU latenc=
y
> >> constraints. However, in many real-world scenarios, such as IRQ affini=
ty
> >> or CPU-bound kernel threads, only a subset of CPUs are
> >> performance-critical. Applying global constraints in such cases
> >> unnecessarily prevents other CPUs from entering deeper C-states, leadi=
ng
> >> to increased power consumption.
> >>
> >> This series addresses that limitation by introducing a new interface t=
hat
> >> allows latency constraints to be applied to a CPU mask. This is
> >> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
> >> embedded systems where power efficiency is critical for example:
> >>
> >>                          driver A       rt kthread B      module C
> >>    CPU IDs (mask):         0-3              2-5              6-7
> >>    target latency(us):     20               30               100
> >>                            |                |                |
> >>                            v                v                v
> >>                            +---------------------------------+
> >>                            |        PM  QoS  Framework       |
> >>                            +---------------------------------+
> >>                            |                |                |
> >>                            v                v                v
> >>    CPU IDs (mask):        0-3            2-3,4-5            6-7
> >>    runtime latency(us):   20             20, 30             100
> >>
> >> The current implementation includes only cpu_affinity_latency_qos_add(=
)
> >> and cpu_affinity_latency_qos_remove() interfaces. An update interface =
is
> >> planned for future submission, along with PM QoS optimizations in the =
UFS
> >> subsystem.
> >
> > My apologies for the very late reply.
> >
>
> Hi Uffe,
> I truly appreciate your review and discussion~
>
>
> > To fully understand how this new QoS interface is going to be used, I
> > really think we need to include a user of it, as part of the $subject
> > series.
>
> Yes, Patch 5/5 using the cpu_affinity_latency_qos_* helper functions to
> replace the logic in pseudo-locking that uses dev_pm_qos_request to
> restrict CPU latency for known CPUs (via a mask). Actually, I'm also
> looking for more users =E2=80=94 for example, we plan to use these interf=
aces
> in our UFS module in the future to implement optimizations. And I also
> plan to support it in userspace on patch V3.

Right, in regards to the resctrl/pseudo-locking user of this new QoS
interface, this whole series looks more like a refactoring to me.

My point is, for this reason alone, I don't think it makes sense to
introduce this new QoS interface. We need another user too, like UFS,
to understand how this would work in real practice and to allow it to
be merged.

>
> >
> > Besides the comments from Rafael and Christian, I also wonder how the
> > user of the interface should know what CPU-mask it should use? For
> > example, how does it know the CPU-mask for the big-cores and for the
> > little-cores? In particular as I assume the user isn't a platform
> > specific driver, but rather a generic driver that should work across
> > various platforms.
>
> This patch introduces cpu_affinity_latency_qos_* helper functions as an
> extension to the kernel existing cpu_latency_qos_* interfaces. These new
> helpers enable users to apply latency constraints to specific CPUs via a
> mask, allowing for more precise power management when the target CPUs
> are known in advance.
> If the user is a generic driver, there are two options:
>
> 1.One is to use the existing cpu_latency_qos_* interfaces to directly
> restrict all CPUs from entering idle, since the driver may not know
> which specific CPUs need to be constrained.

Right, which is how UFS does it currently.

>
>
> 2.However, for generic drivers with specific workload characteristics
> such as the ufshcd driver in this patch:
>
> https://lore.kernel.org/all/20231213124353.16407-1
> -quic_mnaresh@quicinc.com/
> =E2=80=94 if a user knows exactly which CPUs should be restricted, they c=
an
> provide a custom mask via a hook function and use the extended API
> accordingly. The default return value of the hook is the system-wide
> possible CPUs, so it won't affect other users.

Sorry, but I couldn't find in the above series how exactly UFS knows
about which CPUs it should constrain.

Again, please provide a user (UFS for example) of the new QoS
interface as a part of the series.

>
> In summary, this patch is mainly intended for users who know which CPUs
> they want to restrict. For users who don't, the extended API can still
> be used by passing a system-wide CPU mask, or they can simply use the
> existing cpu_latency_qos_* interfaces.

I understand, thanks for clarifying.

This all said, I have to admit that it kind of starts to worry me when
I see the number of different users of cpu_latency_qos interface
increasing in the kernel. To me, it feels like these are just papering
of another real problem that ideally should be solved in a more
central place, for everyone. But hey, that's another separate problem
that we can discuss at some other point.

Kind regards
Uffe

