Return-Path: <linux-pm+bounces-7451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD98BA17F
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 22:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4013D1C20BEC
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E2180A95;
	Thu,  2 May 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW2Dw2FX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79928FC
	for <linux-pm@vger.kernel.org>; Thu,  2 May 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681093; cv=none; b=OjHcrh1ta9PgjUNZ3NPdC0ehPCHfd1iECqxSE8TBGzb9k1ui4Ojh/TwESF/inWfEOT+N09bf9GkLuuBkXfO4+CsYKSaFrqsR9GmOxfFeXd1lmiIa6l289YCF86lu3ASmvIKDr38zyJX3rhaMvFXMbcHb1dfrKAA+lwIpCg43M0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681093; c=relaxed/simple;
	bh=Rr4dZX9hAeT931urBcnwp32IG+pJo2Kj6WSIWSerZyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHlEvF7g7JljyYsXKItVhD4pGxCQN9FPr+fxf/6PTX+6V89Yr32NYWrgqJ6+bxZks4E9NMaapexpJNxhBY17ww86fs52bw30iM+prvMcNPRL4YuoxNfBxYn1as3SvoLxMoHgpxGfslP1YSagr3bicUlpK0Lqgs/Pc0wCiONUe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW2Dw2FX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so108818251fa.1
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2024 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714681090; x=1715285890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J9A//7ksPM9EBg2Kg92EQBbwDco+eGbfOc1EDd4P10=;
        b=LW2Dw2FXBMzfsYN8Twp+Tcn7sXvupJHB2qXhIJEcBd1d/umn9XVPTuonCEl7w0IwgR
         V+oJyLirCK+eO9YVDEP99SWijcQ5/7dSLmO+JIfhWy6CYf6m0GWw9NhJ7SeC+Enw/iZa
         HjpsomxnsOofZPEXKeY5F/YUXUKj9niGk4B8BfWj+QbOLIg/Ss9vBaKvLaYRs2jbPgri
         ijJ2AF0g5bUMKmsP3PCYxnra0vUexeeMPF+nnQH81YY81xmwRm/mlo5WfNfPB2kAK61E
         OawJw++rYmTbe3bE/8/mDsybPWS+qk8HI6tFWAdpytPYTDB+YI9Zsr+U6gCU74QgtHDr
         dYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714681090; x=1715285890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J9A//7ksPM9EBg2Kg92EQBbwDco+eGbfOc1EDd4P10=;
        b=le5y9lNPli+dpvSh9fYHg0+PhsngysgaeDMMHL/Adu5VtXKV1RdFTIOIOdzKr2uLOA
         pfP2RU4BKPk+JF+pxERC6JfhY1vJz3P2mTMkNRHgnG6xAGpcVc+jUzip6DcTTeuGFDb1
         c8IaJqGUuhlsJaKS19dYJfWcdtJX88FWTiJyHLSCJd6T9gByyszEIFW3EHtVHhmzbmll
         NUEyAPArpaG2kvZCVhBjBzSD1nI+T9cwDuiRf/JtGSOvwHPf109idfceX6UX0EBVf9Lj
         Ivq4s/E5mubPWLGxHVOSwJyjP9tQeFaCbJwQ6qJ8AVZMy1g6xtQjYnbRkQf5vjzb42JE
         SI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkoFKWNQKS+jVw4dn4JWpaEGLHvpf5erDd7U1woiLwIigCO9OEaTb5c8xwhHHvsdhn5xmNuK7w0uifeEfrHO/bnIAg5rbzPcs=
X-Gm-Message-State: AOJu0YxoPH0fFrfb+l8+xpLONj4Bp2Gvq+/IpOWgutoovt9GYH574gvx
	iLvZqdZM1VleHkYnadYBVhgzgBppnjqtp4ITHvV5lzI3zywDbV8HVDhOBvKbG0et/9XB6a1j2kb
	hFwZW/7ADObHm2+S9ZZKi0JAO+3qy/hDc1auI
X-Google-Smtp-Source: AGHT+IGRukZGXwciIPXO8qobGIUxrh2o8K8bdJTMJ8DlMnP7Vb9jYCwkv4woe/YdCrIWX4vKRm0QR0XR06tqfuCJesg=
X-Received: by 2002:a2e:22c3:0:b0:2dc:b4f7:dad9 with SMTP id
 i186-20020a2e22c3000000b002dcb4f7dad9mr491137lji.34.1714681089625; Thu, 02
 May 2024 13:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127004321.1902477-1-davidai@google.com> <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org> <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org> <20240215112626.zfkiq2i2imbqcdof@bogus>
In-Reply-To: <20240215112626.zfkiq2i2imbqcdof@bogus>
From: David Dai <davidai@google.com>
Date: Thu, 2 May 2024 13:17:57 -0700
Message-ID: <CABN1KCLbhh9Rf9R2J2UoTS+6Dzc8yysOedKgXizPbQvYuG8tqQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:26=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Feb 02, 2024 at 09:53:52AM -0600, Rob Herring wrote:
> > On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > >
> > > We also need the OPP tables to indicate which CPUs are part of the
> > > same cluster, etc. Don't want to invent a new "protocol" and just use
> > > existing DT bindings.
> >
> > Topology binding is for that.
> >
> > What about when x86 and other ACPI systems need to do this too? You
> > define a discoverable interface, then it works regardless of firmware.
> > KVM, Virtio, VFIO, etc. are all their own protocols.
> >
>
> +1 for the above. I have mentioned the same couple of times but I am told
> it can be taken up later which I fail to understand. Once we define DT
> bindings, it must be supported for long time which doesn't provide any
> motivation to such a discoverable interface which works on any virtual
> platforms irrespective of the firmware.
>

Hi Sudeep,

We are thinking of a discoverable interface like this, where the
performance info and performance domain mappings are discoverable
through the device registers. This should make it more portable across
firmwares. Would this address your concerns? Also, you asked to
document this. Where exactly would you want to document this? AFAIK
the DT bindings documentation is not supposed to include this level of
detail. Would a comment in the driver be sufficient?

CPU0..CPUn
+-------------+-------------------------------+--------+-------+
| Register    | Description                   | Offset |   Len |
+-------------+-------------------------------+--------+-------+
| cur_perf    | read this register to get     |    0x0 |   0x4 |
|             | the current perf (integer val |        |       |
|             | representing perf relative to |        |       |
|             | max performance)              |        |       |
|             | that vCPU is running at       |        |       |
+-------------+-------------------------------+--------+-------+
| set_perf    | write to this register to set |    0x4 |   0x4 |
|             | perf value of the vCPU        |        |       |
+-------------+-------------------------------+--------+-------+
| perftbl_len | number of entries in perf     |    0x8 |   0x4 |
|             | table. A single entry in the  |        |       |
|             | perf table denotes no table   |        |       |
|             | and the entry contains        |        |       |
|             | the maximum perf value        |        |       |
|             | that this vCPU supports.      |        |       |
|             | The guest can request any     |        |       |
|             | value between 1 and max perf. |        |       |
+---------------------------------------------+--------+-------+
| perftbl_sel | write to this register to     |    0xc |   0x4 |
|             | select perf table entry to    |        |       |
|             | read from                     |        |       |
+---------------------------------------------+--------+-------+
| perftbl_rd  | read this register to get     |   0x10 |   0x4 |
|             | perf value of the selected    |        |       |
|             | entry based on perftbl_sel    |        |       |
+---------------------------------------------+--------+-------+
| perf_domain | performance domain number     |   0x14 |   0x4 |
|             | that this vCPU belongs to.    |        |       |
|             | vCPUs sharing the same perf   |        |       |
|             | domain number are part of the |        |       |
|             | same performance domain.      |        |       |
+-------------+-------------------------------+--------+-------+

Thanks,
David


> --
> Regards,
> Sudeep

