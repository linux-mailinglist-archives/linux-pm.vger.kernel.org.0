Return-Path: <linux-pm+bounces-7572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF08BDF96
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF54FB23126
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9415098D;
	Tue,  7 May 2024 10:22:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335C14EC4C;
	Tue,  7 May 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077321; cv=none; b=scr++zS5JiC3ZKImcCXeKXLCzilRODH1D2szH5+blnAeHNfJcUGbtmMB6kfKxmP9nXOMXQiIIeRPH86MVX1JfH/6NV6D5DS1lIdh5/+itg4VeWzgqV5e24vu7NAgprIg8+uIpu5b4FhXFGxiOyvle++fhrrOzApBFXwMnlPfF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077321; c=relaxed/simple;
	bh=CNl70oeFDHm0PkxUM1KSeCUH0N1MpdwxhKDYdJrUe9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrLhoioE8opYaQK8SIYTkgOhpSr+Sfhvxux7kwN+8JLM/qA8ZJdWNikntIMjw2FxMpV+RzLoiX/sKpEmEM2qxSPIIpBE25UajtUVbpACvBNUVr7xCryq8OWT0hnHFdXsj5+dd4oU8irsP7aDo8cvi6EwdcXuPYg0pBymEktmWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B37EE1063;
	Tue,  7 May 2024 03:22:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9633F587;
	Tue,  7 May 2024 03:21:55 -0700 (PDT)
Date: Tue, 7 May 2024 11:21:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: David Dai <davidai@google.com>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <ZjoAwVKvyHzX4_QW@bogus>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
 <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org>
 <20240215112626.zfkiq2i2imbqcdof@bogus>
 <CABN1KCLbhh9Rf9R2J2UoTS+6Dzc8yysOedKgXizPbQvYuG8tqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KCLbhh9Rf9R2J2UoTS+6Dzc8yysOedKgXizPbQvYuG8tqQ@mail.gmail.com>

On Thu, May 02, 2024 at 01:17:57PM -0700, David Dai wrote:
> On Thu, Feb 15, 2024 at 3:26 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Feb 02, 2024 at 09:53:52AM -0600, Rob Herring wrote:
> > > On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > > >
> > > > We also need the OPP tables to indicate which CPUs are part of the
> > > > same cluster, etc. Don't want to invent a new "protocol" and just use
> > > > existing DT bindings.
> > >
> > > Topology binding is for that.
> > >
> > > What about when x86 and other ACPI systems need to do this too? You
> > > define a discoverable interface, then it works regardless of firmware.
> > > KVM, Virtio, VFIO, etc. are all their own protocols.
> > >
> >
> > +1 for the above. I have mentioned the same couple of times but I am told
> > it can be taken up later which I fail to understand. Once we define DT
> > bindings, it must be supported for long time which doesn't provide any
> > motivation to such a discoverable interface which works on any virtual
> > platforms irrespective of the firmware.
> >
> 
> Hi Sudeep,
> 
> We are thinking of a discoverable interface like this, where the
> performance info and performance domain mappings are discoverable
> through the device registers. This should make it more portable across
> firmwares. Would this address your concerns?

Yes.

> Also, you asked to  document this.
> Where exactly would you want to document this?

IMO it could go under Documentation/firmware-guide ? Unless someone
has any other suggestions.

> AFAIK the DT bindings documentation is not supposed to include this level of
> detail. Would a comment in the driver be sufficient?

Agree, DT bindings is not the right place. May be even comment in the
driver would be sufficient.

Overall it looks good and on the right path IMO.

> 
> CPU0..CPUn
> +-------------+-------------------------------+--------+-------+
> | Register    | Description                   | Offset |   Len |
> +-------------+-------------------------------+--------+-------+
> | cur_perf    | read this register to get     |    0x0 |   0x4 |
> |             | the current perf (integer val |        |       |
> |             | representing perf relative to |        |       |
> |             | max performance)              |        |       |
> |             | that vCPU is running at       |        |       |
> +-------------+-------------------------------+--------+-------+
> | set_perf    | write to this register to set |    0x4 |   0x4 |
> |             | perf value of the vCPU        |        |       |
> +-------------+-------------------------------+--------+-------+
> | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
> |             | table. A single entry in the  |        |       |
> |             | perf table denotes no table   |        |       |
> |             | and the entry contains        |        |       |
> |             | the maximum perf value        |        |       |
> |             | that this vCPU supports.      |        |       |
> |             | The guest can request any     |        |       |
> |             | value between 1 and max perf. |        |       |

Does this have to be per cpu ? It can be simplified by keeping
just cur_perf, set_perf and perf_domain in per-cpu entries and this
per domain entries separate. But I am not against per cpu entries
as well.

Also why do you need the table if the guest can request any value from
1 to max perf ? The table will have discrete OPPs ? If so, how to they
map to the perf range [1 - maxperf] ?

> +---------------------------------------------+--------+-------+
> | perftbl_sel | write to this register to     |    0xc |   0x4 |
> |             | select perf table entry to    |        |       |
> |             | read from                     |        |       |
> +---------------------------------------------+--------+-------+
> | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
> |             | perf value of the selected    |        |       |
> |             | entry based on perftbl_sel    |        |       |
> +---------------------------------------------+--------+-------+
> | perf_domain | performance domain number     |   0x14 |   0x4 |
> |             | that this vCPU belongs to.    |        |       |
> |             | vCPUs sharing the same perf   |        |       |
> |             | domain number are part of the |        |       |
> |             | same performance domain.      |        |       |
> +-------------+-------------------------------+--------+-------+

The above are couple of high level questions I have ATM.

--
Regards,
Sudeep

