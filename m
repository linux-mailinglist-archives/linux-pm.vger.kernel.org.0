Return-Path: <linux-pm+bounces-4705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF9872E4D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 06:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027A31F2534D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA81426F;
	Wed,  6 Mar 2024 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNVbIEb+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4D1AACA
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702681; cv=none; b=n/xc93yuOR0//4HMIGIY9aYupg/xecftqZyyUl9U7A4OVy79saKzZZtiM7ynIsSG/8lg1BXmh9G45yAmeTnSVSDKItCzo22Merzgb5e0ZV4i3gzD6BloYCT+IbHvl6Wxfj7Zth7R79W9QRG5/1CROCHNwiB66Ph22g/HYm5amq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702681; c=relaxed/simple;
	bh=ZT9hOjcjWi/oD/L3FfqkAn4tAL+bjQNxT2iPUwDZBs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvXYdSsgtB+L4j9lOjEyHBP6FhazXhGM/MHr8YcoSrScqv/vxYxSSQ0ES+RwXGXAzbw/i+1jq60huAArYeyllEM26+hmlFbr5bSfjQl+83RJFfalO17lBw7wjoHsUZpDEEha7syyFc5RdXwVAVAm5eWoeWfxSQxKAPrLpTJAhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNVbIEb+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd2c8f1204so10831895ad.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709702680; x=1710307480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qA7H43N6+SGTqrqdgH+ITMwNnXCpkc32RIfzdkvT6jQ=;
        b=kNVbIEb+lL4OKHeIj0YLNXnglvV++5AM48+q7tBf9uCuZlpsxRmbDD6OvyTGW/pIHo
         eAqNvSbWucCkqxGtiblz4+6zyEcPHaGfk7IYSo3tEqAUuQ3n0hN9GikvMH7II2P4FpB0
         ClBqOE06zdFZrfKyDXSLjckaDanEnULDjx4z6G5T3F6VRp+h54JkKxNRrfcsMJCQdcL/
         WF9F0B/B6yDbpHl7TU6WkeAItEYaktPs6kaCjaldD7Mk4nFvy5ooomk0WQpc4pUg5o32
         lh8B9rwFC8cuqInEYcqnjVA5LOPwMMs5woNRKeauBtnCjUf2arQhgsIDOLwl2kPL+SqL
         KdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702680; x=1710307480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA7H43N6+SGTqrqdgH+ITMwNnXCpkc32RIfzdkvT6jQ=;
        b=iQ+6fApTV8JKEVVS2EdWydhobuA+vA2i2UL+TUvQvuk3iqqOz/v6grWJ7azzgZpij0
         dI84+FRyeAVCNTWZPI0DirXv0HaZqtU6McwP9dM5FjO/ejYVUsbzaDR65RmDYyXOjiMc
         VOnaaND7rypBRZxPhKbdSjduWvT9pesaO/5K4dEEkSpvWUWUUTw445ZT6HV5cZFLGuwB
         CdhHDHk6keSGbPvWijb7aMB4eehTRENzkSmKmGeByozPU+lBiq4XkmXsHUZipEEH8uC7
         HGHdw70kzzHSiSpm156S6dTbI5LSFVASq4H+KlGZpbjSxZsCaeQjVRAE8WapuE5Su2tS
         Sz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+TfWHszW1OD7Pq2jYHDscVxhJGB1ZdyIqU6+z3kF6o9bvi6hpQa+C6Yh4DUpo3zwLfcUxiliCidS+KPaFeKHwCkVxW7bKv4I=
X-Gm-Message-State: AOJu0Yzujo60tOkxft085mT4cMmglMzuHNOwjskLecVfcoHuy+0xCyz+
	Rfq0mJ+LJ6XQwF6Of+P+gujT7oQyrfXfFFUAJGa4xJS1qy13TonTK/oTR8hU08ArXcsBnG6y9Um
	4
X-Google-Smtp-Source: AGHT+IH0ZyDRTolzKPKAbXqYCjmXgWdRFTovIIC084UoGculvfaBHZdEk6w9URrLSn0hJFvAnhtpFw==
X-Received: by 2002:a17:902:d2d2:b0:1db:b8f9:ea69 with SMTP id n18-20020a170902d2d200b001dbb8f9ea69mr5203253plc.34.1709702679590;
        Tue, 05 Mar 2024 21:24:39 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001dca3951a39sm11536234plc.81.2024.03.05.21.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:24:39 -0800 (PST)
Date: Wed, 6 Mar 2024 10:54:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Message-ID: <20240306052436.rt5uqkakrgfcleew@vireshk-i7>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>
 <ZeWzs_g6FvQlHQN7@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeWzs_g6FvQlHQN7@bogus>

On 04-03-24, 11:42, Sudeep Holla wrote:
> On Mon, Mar 04, 2024 at 12:30:58PM +0530, Viresh Kumar wrote:
> > On 22-02-24, 14:56, Pierre Gondois wrote:
> > > policy's fields definitions:
> > > `transition_delay_us`:
> > > The minimum amount of time between two consecutive freq. requests
> > > for one policy.
> > > `transition_latency`:
> > > Delta between freq. change request and effective freq. change on
> > > the hardware.
> > >
> > > cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
> > > value if available. Otherwise a value is induced from the policy's
> > > `transition_latency`.
> > >
> > > The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
> > > Values matching the definition are available through the SCMI
> > > specification.
> > > Add support to fetch these values and use them in the scmi-cpufreq
> > > driver.
> >
> > How do we merge this series ? I can only pick the last commit.
> 
> I have sent my PR for v6.9 already and was deferring this to v6.10
> The changes look good to me. If it doesn't conflict much with -next
> SCMI content, then I am happy to ack and you can take all of them
> together. Otherwise we can revisit strategy at -rc1. Thoughts ?

Applied. Thanks.

-- 
viresh

