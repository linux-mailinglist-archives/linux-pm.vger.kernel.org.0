Return-Path: <linux-pm+bounces-22314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA01A39E2C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8013A9C24
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42669269AE8;
	Tue, 18 Feb 2025 13:59:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D812417F5
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887155; cv=none; b=perbzYQnRWaIPIGU3+CnSrmnSAtCYl7fOQAdUuTVybyuSdEFfgyaHmvcbWLgc8qC3xittgwV0gxiVrwUQjHyxPy63rqvSkrS57OOqChCjQR7CKmmrzm1WX9efhzNLM0ZbOFN52/ail+rEXXoiGnBY0LviKPQR2EYb1HeqNuAQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887155; c=relaxed/simple;
	bh=2dw3vhFkFr3TaomQkOTF+/iPnMob0f7dv5p6Z04/y6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snzyiko+HGZq44PPARXKn9BifO/3lusi892Vg7LZSWEIquZR0LQymaL1sYDk5BAurB6Kn6L6BBRqWRTVp9s2ouJ9MPZjGiSOUU3cAVbdqo4N8u3X0guNEf6lN+i+Ulzd0/0VlrCQ30cS6Mke58j9mUqv9ZUL9mSZVo2zCHWIifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E518C152B;
	Tue, 18 Feb 2025 05:59:30 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D8C3F6A8;
	Tue, 18 Feb 2025 05:59:10 -0800 (PST)
Date: Tue, 18 Feb 2025 13:59:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Message-ID: <Z7SSKwMtY8j4XWJI@bogus>
References: <20250217140145.117086-1-ulf.hansson@linaro.org>
 <CAJZ5v0hi=zCuhmVRf2HVRWkR53U7xqxC3oQDs8-JN-cyQ+ZX1w@mail.gmail.com>
 <CAPDyKFq1w7Ez+6GSKDeCpeQ=Xm4c3U9BMu3G8q+v2MXk1TdwKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFq1w7Ez+6GSKDeCpeQ=Xm4c3U9BMu3G8q+v2MXk1TdwKw@mail.gmail.com>

On Tue, Feb 18, 2025 at 01:54:44PM +0100, Ulf Hansson wrote:
> On Tue, 18 Feb 2025 at 13:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Feb 17, 2025 at 3:01 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Add myself as a co-maintainer for the cpuidle-psci driver and the
> > > corresponding git-tree, which I am already using for this.
> >
> > Lorenzo, Sudeep, any objections?
> >
> > Ulf, do you want me to pick this up?
>
> I can take it via my pmdomain tree, but thanks anyway! Let's also
> leave some more time for Sudeep/Lorenzo to comment.
>

Sorry for the delay, accidentally marked it read and missed it until these
emails. I have responded on the patch with an Ack now.

--
Regards,
Sudeep

