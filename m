Return-Path: <linux-pm+bounces-7956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A78C8D80
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F912841F9
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E023C489;
	Fri, 17 May 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19TyXORL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D8140E30
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715979590; cv=none; b=UGGlJlUcr+BTyeuKMdwGCvZF/S/1ksKiIW/2KdXvGIsyy3jfm88amPZRlBIKuuALEVrXm0BrwdYTZyV2m8BXJFuW55J2GjjwkJCKWCg7O9rH13zPvow/zrfb8iIV+Tx4zYQ6d3O9rScNMoyUF2XhWVSN35m4GcN8u4J1yn2EzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715979590; c=relaxed/simple;
	bh=0TZxtabTN9ES/yjWEVp1TeEISsbnCtrQpRlL28vKIKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQK0+C8+p07P0qeMFrc8Z8PxiKOzwGM6TcYfT+Sj1CP7OYuHBZysnRGMINIDuPZokARsiX9i4f5xYqRl6slZbuKEkSsq2DfaBnBhTRc0SiErxm/C9Nal+vvccMr7pxpVOgK4tjNHWXOpkEYW5GtYDay3Zu5Y7YCDQklFbHiYqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19TyXORL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-351ae94323aso458484f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715979587; x=1716584387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6O0tC8na6Pj3c9nhuKHr2BFcOQR/Gezv9wh+gJUdbU=;
        b=19TyXORLVN8H/DqVeZgeOXtDnQuVz+vPzIFm3loOT3S+jPuOrdXO1qEwxPofs3+EF1
         Ak10nByMEpyGD124SHrQIs33bXErLLaGyTSC8GGMLnKdLOCb4m/y8p2S521wFmKzKuLR
         ORGaRtBXlHXxcfk5muYKDOj6cVN8SxMCQOXnQ9Dwhx9EVrqcuGN1mxYP1j/yL4eM3KpE
         TFhgfGlRE4Fm1/CUKYran0nBYXDNBHGJCkdFzWfDOO0giYuAfPYxxSKZYiMGqtUFB3Ob
         4wcbYRnXZrKuOibejN7GVlLOz3+w6PC0sZ19GLNfR8k9rR3exUaRQV0VkpMXFSizWMUM
         fA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715979587; x=1716584387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6O0tC8na6Pj3c9nhuKHr2BFcOQR/Gezv9wh+gJUdbU=;
        b=FJsJ+isO75aAS8H2MdamJ32VScjCVtTKncRC0xT7gH3apF1DEH90L9yDaCOFNwDfmx
         01+p2k2iz1GkSfoPt4xdCkUSsREnGq34akOENk5NjCbOfb2IqoaXlukY/IyCrdw8UgIt
         k5wr0TeZ3Qc2IWLHiUHn6JMIIPguYtShzLuuckfreNXtXJiYOSqjThoqqMopBjKjecIz
         MOpDp0OyVaTmPgPb6M9Btpsj3kX94v3aP+dWKYvjQiRq/On9EqTGoqybxvkHJ35PzBo6
         TzQwfTUPGE0m6k5w4MUDY3boOs1pWIlTs529ufLiznmkfImFiyxoPud9ZKUwfV5ZKepT
         743w==
X-Forwarded-Encrypted: i=1; AJvYcCVEBLos6bFn3bl5Yi8vH1pL1VBIqTBwQgD2ZILAx6oC4rPf/NOJZg1QYvcoFY/d3cRS4OHfc53+HkVKt+EOimMU30TdrsD2Mqk=
X-Gm-Message-State: AOJu0YyuOkpQlUU1Hd2k0u/phkt7TkNJke8CSjUs4HNib7JOEPXBPDY7
	GhTSsQOskln+9k+n68gp2LHZWghjReTvh3ygEuc6cIUph1b30XuzjSIcibswCjgzKqRRMTZeuAu
	MrqU0M1bEuSPupmS6QtNSKNyIFIsI05L1LL0P
X-Google-Smtp-Source: AGHT+IGhIiX3M7zHX/c/sT/HHbRWZo1wnXb6C38RXtq2uUkXk2rK+mfOp74wDEFz8G/GWAFGkLyz6440mpHNuoZxsyA=
X-Received: by 2002:a5d:4451:0:b0:349:cd18:abbd with SMTP id
 ffacd0b85a97d-3504a96895dmr16923988f8f.46.1715979586981; Fri, 17 May 2024
 13:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127004321.1902477-1-davidai@google.com> <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org> <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org> <20240215112626.zfkiq2i2imbqcdof@bogus>
 <CABN1KCLbhh9Rf9R2J2UoTS+6Dzc8yysOedKgXizPbQvYuG8tqQ@mail.gmail.com> <ZjoAwVKvyHzX4_QW@bogus>
In-Reply-To: <ZjoAwVKvyHzX4_QW@bogus>
From: David Dai <davidai@google.com>
Date: Fri, 17 May 2024 13:59:35 -0700
Message-ID: <CABN1KCJbuZ-+VmvF4OhtngZr095F6RZ5BipGvF8chqKkoZkG4g@mail.gmail.com>
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

On Tue, May 7, 2024 at 3:21=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Thu, May 02, 2024 at 01:17:57PM -0700, David Dai wrote:
> > On Thu, Feb 15, 2024 at 3:26=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Fri, Feb 02, 2024 at 09:53:52AM -0600, Rob Herring wrote:
> > > > On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > > > >
> > > > > We also need the OPP tables to indicate which CPUs are part of th=
e
> > > > > same cluster, etc. Don't want to invent a new "protocol" and just=
 use
> > > > > existing DT bindings.
> > > >
> > > > Topology binding is for that.
> > > >
> > > > What about when x86 and other ACPI systems need to do this too? You
> > > > define a discoverable interface, then it works regardless of firmwa=
re.
> > > > KVM, Virtio, VFIO, etc. are all their own protocols.
> > > >
> > >
> > > +1 for the above. I have mentioned the same couple of times but I am =
told
> > > it can be taken up later which I fail to understand. Once we define D=
T
> > > bindings, it must be supported for long time which doesn't provide an=
y
> > > motivation to such a discoverable interface which works on any virtua=
l
> > > platforms irrespective of the firmware.
> > >
> >
> > Hi Sudeep,
> >
> > We are thinking of a discoverable interface like this, where the
> > performance info and performance domain mappings are discoverable
> > through the device registers. This should make it more portable across
> > firmwares. Would this address your concerns?
>
> Yes.
>
> > Also, you asked to  document this.
> > Where exactly would you want to document this?
>
> IMO it could go under Documentation/firmware-guide ? Unless someone
> has any other suggestions.
>
> > AFAIK the DT bindings documentation is not supposed to include this lev=
el of
> > detail. Would a comment in the driver be sufficient?
>
> Agree, DT bindings is not the right place. May be even comment in the
> driver would be sufficient.

Alright, I=E2=80=99ll make this into a comment in the driver itself.

>
> Overall it looks good and on the right path IMO.
>

Okay, I=E2=80=99ll submit V6 patches and continue from there.

> >
> > CPU0..CPUn
> > +-------------+-------------------------------+--------+-------+
> > | Register    | Description                   | Offset |   Len |
> > +-------------+-------------------------------+--------+-------+
> > | cur_perf    | read this register to get     |    0x0 |   0x4 |
> > |             | the current perf (integer val |        |       |
> > |             | representing perf relative to |        |       |
> > |             | max performance)              |        |       |
> > |             | that vCPU is running at       |        |       |
> > +-------------+-------------------------------+--------+-------+
> > | set_perf    | write to this register to set |    0x4 |   0x4 |
> > |             | perf value of the vCPU        |        |       |
> > +-------------+-------------------------------+--------+-------+
> > | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
> > |             | table. A single entry in the  |        |       |
> > |             | perf table denotes no table   |        |       |
> > |             | and the entry contains        |        |       |
> > |             | the maximum perf value        |        |       |
> > |             | that this vCPU supports.      |        |       |
> > |             | The guest can request any     |        |       |
> > |             | value between 1 and max perf. |        |       |
>
> Does this have to be per cpu ? It can be simplified by keeping
> just cur_perf, set_perf and perf_domain in per-cpu entries and this
> per domain entries separate. But I am not against per cpu entries
> as well.

I think separating out the perf domain entries may make the device
emulation and the driver slightly more complicated. Emulating the perf
domain regions per CPU is a simpler layout if we need to install eBPF
programs to handle the backend per vCPU. Each vCPU looking up its own
frequency information in its own MMIO region is a bit easier too when
initializing the driver. Also each vCPU will be in its own perf domain
for the majority of the use cases, so it won=E2=80=99t make much of a
difference most of the time.

>
> Also why do you need the table if the guest can request any value from
> 1 to max perf ? The table will have discrete OPPs ? If so, how to they
> map to the perf range [1 - maxperf] ?

Let me clarify this in the comment, the perf range [1 - maxperf] is
only applicable in the case where the frequency table is not
supported. The cpufreq driver will still vote for discrete levels if
tables are used. The VMM(Virtual Machine Manager) may choose to use
tables depending on the use case and the driver will support both
cases.

Thanks,
David

>
> > +---------------------------------------------+--------+-------+
> > | perftbl_sel | write to this register to     |    0xc |   0x4 |
> > |             | select perf table entry to    |        |       |
> > |             | read from                     |        |       |
> > +---------------------------------------------+--------+-------+
> > | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
> > |             | perf value of the selected    |        |       |
> > |             | entry based on perftbl_sel    |        |       |
> > +---------------------------------------------+--------+-------+
> > | perf_domain | performance domain number     |   0x14 |   0x4 |
> > |             | that this vCPU belongs to.    |        |       |
> > |             | vCPUs sharing the same perf   |        |       |
> > |             | domain number are part of the |        |       |
> > |             | same performance domain.      |        |       |
> > +-------------+-------------------------------+--------+-------+
>
> The above are couple of high level questions I have ATM.
>
> --
> Regards,
> Sudeep

