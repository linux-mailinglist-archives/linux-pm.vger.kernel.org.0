Return-Path: <linux-pm+bounces-25015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80603A8263A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A601898F70
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0AB25B66B;
	Wed,  9 Apr 2025 13:21:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61008218EA2;
	Wed,  9 Apr 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204897; cv=none; b=fdk3l0fqpqusa32X1wY0X9ELQTQwi3bV1U2EjN0SH9LKPVvqOfip9cDAkEwrAqVSzFQiSX9hGwnx9SE/T4q36DkY7LdwU4Yp0SP9hoXsNzA1hOdpcKoJtwsBC60/IU9YgnVB0g5D1MOXS30QSluPuSham12nYKikLqQjOtO5PgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204897; c=relaxed/simple;
	bh=zr4G9PuRlvn1Iebs/Po3WpTXgWWeStxGqrwJOl40BRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFPh46Y77s4uIcuTrQgtGLGDT6k2zb1BOsX+6nyy/uSPvsPwSU5dFIkKOi1h46Ilxe9sCDQpleUUu4cffr91p8kqVhAFn2iLlDT8JErwfApwyvL5ShSWZiCqmjz09p1Q/DYuoj/QrUtC82TaiyJuEzex7LGSN1X4jdw/7DgC7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1541B15A1;
	Wed,  9 Apr 2025 06:21:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCFAE3F694;
	Wed,  9 Apr 2025 06:21:32 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:21:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Henry Martin <bsdhenrymartin@gmail.com>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference in
 get_rate()
Message-ID: <20250409-glistening-hasty-ape-c9c7e9@sudeepholla>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
 <0558b7f7-8c69-4664-afc6-bae4fdc6f071@web.de>
 <20250409-merry-gay-lemur-8288cf@sudeepholla>
 <52aa52a5-7081-41ee-872e-f1728c06daf1@web.de>
 <Z_Zhp38o9KiicPVw@pluto>
 <3f5662dc-7547-4585-a396-4546fa98d34f@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f5662dc-7547-4585-a396-4546fa98d34f@web.de>

On Wed, Apr 09, 2025 at 02:25:52PM +0200, Markus Elfring wrote:
> >>>> Can any other summary phrase variants become more desirable accordingly?
> >
> > I agree with Sudeep, the above sentence is completely incomprehensible
> > to me
> 
> Can any suggestions gain acceptance also for better summary phrases?
> 
> 
> 
> >>> This is meaningless, sorry can't parse. Ignoring it as others in the
> >>> community are doing already.
> >> Do you care if the term “null pointer dereference” would be used in consistent ways?
> >
> > ...this is more comprehensible,
> 
> Thanks for another bit of constructive information.
> 
> 
> >                                 but again I cannot grasp what's yor advice
> > specifically on this commit message.
> May the usage of abbreviations be reconsidered once more also for such messages
> (in presented update steps)?
> 

Still can't understand you. Sorry for that. Alternatively, you can do what
I sometimes do: just write the whole commit log as you would expect and see
if that helps. I am sure that helps, so please do that.

-- 
Regards,
Sudeep

