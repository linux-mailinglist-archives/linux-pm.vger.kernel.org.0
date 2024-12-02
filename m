Return-Path: <linux-pm+bounces-18383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52F9E0D77
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C04A1655CE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F81DF245;
	Mon,  2 Dec 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+GvnVv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE01DDC24;
	Mon,  2 Dec 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173192; cv=none; b=fqWr9IbcdKsKVDgt1cs1+r6ayV5SAShtwS+3CVK0yduILrkpyGPESy93FzDxOordiefUCP0PQZ5T7bvn0K7yRxka+HvwYWcJyBkgUPRm7lDv8w8MjP7QO25i2Qzij4JfaqEouJ9tJsVxePynxVIIEnmfImuDCPTcM0nDtkY7s/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173192; c=relaxed/simple;
	bh=2PK5ha2wx0lgaGR40rHwlMuiaDdWxyYKuGnI/G4Plgc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX59QH+tL/6aVak4hhT3mKUzLi2AHVqwhPVk3htZ6H1+yjnNW5+lLGr78IxkMOV8yd/YdPJEoGElRdDbVW8Jg7S4YhhLwbs8RcpvLv4wBrJlBJzpNIZeKZQOLJKlBXAda298WGlxevQFq3KrxqZthvu9BrrY7g0seGhPyDxGShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+GvnVv5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385d6e36de7so4141864f8f.0;
        Mon, 02 Dec 2024 12:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733173189; x=1733777989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMjaw1yBGxjyAFkiqRAKXLHvRiHxJiioylVtFCyhof8=;
        b=e+GvnVv51M6G6LmGpYKeEIYwakPMpG2+8JWllA3Ga5YUg142BEDR8DF0MPih0wco2y
         biOHHAuvGHkQJ5V/IKQDWI88+MdRSse/0gE70e3ow0ZAYgQ+AFI/lq8ekYHbPdx0ypgM
         0110t4UYWa9NkbdsoisrDTroQ5LYsjsUJDRNzVaSIjzTLqz9TvRNt8EVzg4yuyGnl3ZZ
         V8GYPy7G9F59TwpXjh+7CNhBkce/NciavrUjQ+FvalhaHsnJfmaTEBwpHOS/ca0kaXaw
         oAzoimDxszE120ru/loOMhro67HOOtnXihQ1nFhKjQ9WqjJJvsJpUb1K5aK3jq7lNjUk
         tgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173189; x=1733777989;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMjaw1yBGxjyAFkiqRAKXLHvRiHxJiioylVtFCyhof8=;
        b=WpieEVLhOGycvppkRiRyNHdmZjJWhxQew4FsbdDfK1SdwDmgg9g6dQVmhrLc4FX8SW
         2AEfGhwt+B/CwdvATP7Id6Tx5hoJV2tKZ132pP5PeYn4TPT4l3TGkp4wLARxy1tzRpG+
         s9ZJYz+twWgJTcPwWNm8VTMQoNPb5fbyi8Lj23JgUhxZ4UjNMVmmDNhOa9UA3X6XiZe7
         CMld8iL6NPaa1GtYTDCBHfMsKjKgHViSTLXxqg9q4EECE9VzuTXoUs7oZNPpgiIdxemn
         jS+4F+xY1TBySzJavjOrShb8YgwmIczLoBNZDH06dkNJAJfXOwS4TZNHhFAaqWXwoxvW
         RdPw==
X-Forwarded-Encrypted: i=1; AJvYcCV76M8vHRnzupyEFy8GrspBvE0p2CO78nF/pXWhaSYhDivOFOPt6aVFkF6ke06PjUwFro3rfXzk2mJzlBK/@vger.kernel.org, AJvYcCWVMrvuKBIkO349HIqp8Y59HJXgfnMH6Y32PbUvExt3U/nRWAjvMI5CD+IcTJc2G4SGllPVGaVPMlke@vger.kernel.org, AJvYcCWaZsXcoylpPlHgmX6ejPIxnqeguOEUmlG/5IkO7exnoBTEGCimUQHq2WqrkIV1A0WvUamgF0Hu8wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9/RexCdEGVJGywyDKb1D8/bZSyxWiTqUfbb+OwTnQLI9vtoq
	ZkzA18t1lpnu7z1Lp8gpSQgKfBBTl5rabdT/cqZdjkhnVI9lkv0xu32Luw==
X-Gm-Gg: ASbGncvjYdChliQsGregq1CeKaM6EKYjv80eOShOsLO9HUYu4oK56jt/z6sEFbrdtRU
	Cf7NyGOvSZniiMlF4ya2LDb9LLwuVbZz/X7dnMBmttOWbg4GlZTsWzVILrKdxw/+vyb82ZtECbY
	gS1XiVIIo9LqS8F30IgWxu+I/id47ylZPSI1Q8IwtxwjWnl//+zwW4+btSWX6zJfv88y0kkCGfB
	kK+TMCSZn3bq0uXrWp1Nc+W47sZ3HrjQcreA8H9SgWEj7ePoBfDlenERfK/cXDt0Ru/NHki4nvS
	+ZhaCA==
X-Google-Smtp-Source: AGHT+IHhdAUMBDhh/fABRlqFfHvgANTFrgvyVHAUXfoPzB6A1STCBLs6LN6aqRXQ9wlQ9Hj9wW7l3Q==
X-Received: by 2002:a5d:6da4:0:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-385d7f9f23fmr17710725f8f.46.1733173188463;
        Mon, 02 Dec 2024 12:59:48 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd80435sm13308858f8f.100.2024.12.02.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:59:48 -0800 (PST)
Message-ID: <674e1fc4.050a0220.a615a.6ff9@mx.google.com>
X-Google-Original-Message-ID: <Z04fwdEkNp_-T98L@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 21:59:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>
 <20241202205738.GA3149730-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202205738.GA3149730-robh@kernel.org>

On Mon, Dec 02, 2024 at 02:57:38PM -0600, Rob Herring wrote:
> On Mon, Dec 02, 2024 at 04:45:17PM +0100, Christian Marangi wrote:
> > On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> > > On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Document required property for Airoha EN7581 CPUFreq .
> > > >
> > > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > to ATF and no clocks are exposed to the OS.
> > > >
> > > > The SoC have performance state described by ID for each OPP, for this a
> > > > Power Domain is used that sets the performance state ID according to the
> > > > required OPPs defined in the CPU OPP tables.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > Changes v4:
> > > > - Add this patch
> > > >
> > > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> > > >  1 file changed, 259 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > new file mode 100644
> > > > index 000000000000..a5bdea7f34b5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > 
> > > [...]
> > > 
> > > > +examples:
> > > > +  - |
> > > > +    / {
> > > > +        #address-cells = <2>;
> > > > +       #size-cells = <2>;
> > > > +
> > > > +        cpus {
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +
> > > > +            cpu0: cpu@0 {
> > > > +                device_type = "cpu";
> > > > +                compatible = "arm,cortex-a53";
> > > > +                reg = <0x0>;
> > > > +                operating-points-v2 = <&cpu_opp_table>;
> > > > +                enable-method = "psci";
> > > > +                clocks = <&cpufreq>;
> > > > +                clock-names = "cpu";
> > > > +                power-domains = <&cpufreq>;
> > > > +                power-domain-names = "cpu_pd";
> > > 
> > > Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> > > indicate it's a power-domain with performance scaling support.
> > > 
> > 
> > Will change to cpu_perf. Thanks a lot for the review!
> 
> Is that defined in arm/cpus.yaml? No.
> 
> The current choices are perf or psci though those aren't enforced (yet). 
> Or nothing which is my preference if there is only 1 power domain.
> 

I would also prefer not having to define the names property but I guess
that is mandatory for the PD APIs? Maybe Ulf can confirm. 

-- 
	Ansuel

