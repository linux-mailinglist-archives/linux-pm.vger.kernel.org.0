Return-Path: <linux-pm+bounces-43697-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJGiEtq4qWlEDAEAu9opvQ
	(envelope-from <linux-pm+bounces-43697-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 18:09:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8871215E41
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50592300AB20
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AF3E0C41;
	Thu,  5 Mar 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0GI0noQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D53DBD6F
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730581; cv=none; b=LJkLf9kR2i5crLnq0aBGA9Bgw76175J6QatmTINbCrOPxp8RfsY/gyiXCtbNBHTFaMX9SgwVCEzb5szO4O9tHjxxLd/WsDT/10VFCclQfkCQ8IimynGma+ga7afZuoH4IGdkTWYXCIGZgGuP4w9SmnlWQgSJaDZxkvW794pVgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730581; c=relaxed/simple;
	bh=QYLm+5Rs5AJwatSWGCk6jd6QWUZZSU4/Nsrh+DKO1SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+1VwyXq8XLvwwLrELV4LBKSm5/16+eAAdHJ4qe323v8St3LsatDgo8mYhpAVzWYJi3S5tOIYVEZqYwTXSQKQbhnS1drRDTgFT+5HSnA8hxzerLa7E6XeywY70NArGkfNsx6sRy98BYCL3/0a4Uzxl/+tPrtuc2NJj3SxCqjMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0GI0noQ; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12713e56abdso5118402c88.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730580; x=1773335380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0LMTjXkZSK17nahPAopPxOjENVtdK5q1MgyibnZgUE=;
        b=F0GI0noQlS7ODcoR4OocqOJW4XlSXsf1BiQgpWb98bhALcHrqOHaWHM0LplWvcFI3B
         1rwbnkhNHowcmiUbK/KHoYRvo3jxh79XDMD3woCmgBHSEPWcKZTYMgC/qb6UW1RzoMOo
         ouZyNFFwRjjR8MPcVCR9ZjPNNfgCD5bkbwMAbtGCwqMC6nFNB7JuEsYqrUWcv4FUovFK
         nvoVt1UrVISjiB568r9XhNILQyIRDSeBIBaAug/Gejvj4GrlHOiQxFvX5sRVurJmBKB4
         ODenF+fCar8PlTgLSLJ39ci6ZzwjGbtl3O43VXqUf955XGtfWqiUcT4/4CrM9zq86/Ge
         MuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730580; x=1773335380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0LMTjXkZSK17nahPAopPxOjENVtdK5q1MgyibnZgUE=;
        b=wVioLlicRXGPIt5MGaK8fvhiOE0PSjeduwXaDdRLjVQjOmoWI7gwv+W55RIocqNg8Z
         w9BFCuP+OANugcxZYGFXdpISd39EiTHxoL3uEZ3FSRE+JidfqcypLLLB7QrrruHitNVK
         WV5evX+eBN4058IX1k95hy8X3fPLNc7UJzJmv/N1hlgEhjvb7lXk7p2QBgL9zRFTWbdg
         r123qPd4/1qTRG0XS7C5XlK5MbrKpZszRk9WVsfrHpx9W1x2w31BXcnQE4Sm+2cuLcHk
         qCMp/WbnMiBCv64hGfwcctLVmiDiS8k2qpFGm1bdJLa8sdPiSgn08FBpFHz5oU/qPzRb
         JZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCXT0Dd3AxVsk4YybT2TXx2EaXROuM4ZlDx7V9hCuDBwC6s/IR1mRohi0krzmQ8Q3N+4pbKapVVtCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZS4ZL4DKvTAgsrR0aokdOE0BWDN1U9OdoEVBfBqbatYsa3aNn
	sIf6JIPPYXnMnAjc93gs4uCZLXQs2O+bKLVBDgMX6zkOm9AsbSM8HlGP
X-Gm-Gg: ATEYQzxKrInKCL55thPghUeca1ovBqNdMkNGIihFGNNbWa7JNREFYi9NwIY2KEJfJJH
	JPHm0662g+TIOXFA1mf2eU7SkhICFld4xlfzDlFq1TXb7Fpb1YXH9RQLqGCAucILyTzqljNhIix
	bFqLaa5csZMIi1fz0zx9iJKTJjpX5fQpxozd87hVp6vQp9Yg6gBkTKdk798H3cVPamR+3+1n3CX
	6ZTio4QMcFMolEfZ9wczJ2K8ywXgOk8sV6an6NJKURVNNUQ6kXXmjhAJlcDRHKB2eCyKBHrToyr
	N7ykaqGdTvNqU0f99fD8VhGE5OSQ1zWSMWYeCCHzk2/MyHVofj1vfYLh83zHXnVMCrnrl7muFFa
	as3txJb6XebZ3nT6AVvMBej3DZW/DPXNEABRZJIcenAqAaatMqXr95nA7iKEzVUMwDMoPikyIIi
	slUFWTdMmuLD++DjJw48DS04iMKOKmYhro1Oiq
X-Received: by 2002:a05:7022:f8f:b0:128:b534:bd04 with SMTP id a92af1059eb24-128bbfa3ca4mr1138885c88.5.1772730579267;
        Thu, 05 Mar 2026 09:09:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32863sm20676965c88.10.2026.03.05.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:09:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 09:09:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, christian.loehle@arm.com,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state
 is available
Message-ID: <7f84ebb8-1802-44d4-8b63-1ad026f0baa6@roeck-us.net>
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-2-aboorvad@linux.ibm.com>
 <37ab17cd-0488-44bd-9e03-1ba3c0757e8f@roeck-us.net>
 <CAJZ5v0hKAcAqWuR41bwjjpQuhs6poHrNFwQABeGz1w3j3b6Pww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hKAcAqWuR41bwjjpQuhs6poHrNFwQABeGz1w3j3b6Pww@mail.gmail.com>
X-Rspamd-Queue-Id: E8871215E41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43697-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,roeck-us.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:06:53PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 5, 2026 at 5:53 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > On Tue, Feb 17, 2026 at 12:20:02AM +0530, Aboorva Devarajan wrote:
> > > On certain platforms (PowerNV systems without a power-mgt DT node),
> > > cpuidle may register only a single idle state. In cases where that
> > > single state is a polling state (state 0), the ladder governor may
> > > incorrectly treat state 1 as the first usable state and pass an
> > > out-of-bounds index. This can lead to a NULL enter callback being
> > > invoked, ultimately resulting in a system crash.
> > >
> > > [   13.342636] cpuidle-powernv : Only Snooze is available
> > > [   13.351854] Faulting instruction address: 0x00000000
> > > [   13.376489] NIP [0000000000000000] 0x0
> > > [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
> > >
> > > Fix this by adding a bail-out in cpuidle_select() that returns state 0
> > > directly when state_count <= 1, bypassing the governor and keeping the
> > > tick running.
> > >
> > > Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
> > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > ---
> > >  drivers/cpuidle/cpuidle.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > > index c7876e9e024f..65fbb8e807b9 100644
> > > --- a/drivers/cpuidle/cpuidle.c
> > > +++ b/drivers/cpuidle/cpuidle.c
> > > @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
> > >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >                  bool *stop_tick)
> > >  {
> > > +     /*
> > > +      * If there is only a single idle state (or none), there is nothing
> > > +      * meaningful for the governor to choose. Skip the governor and
> > > +      * always use state 0 with the tick running.
> > > +      */
> > > +     if (drv->state_count <= 1) {
> > > +             *stop_tick = false;
> > > +             return 0;
> > > +     }
> > > +
> >
> > An experimental AI review agent provided the following feedback:
> >
> >  Does this unconditionally keep the tick running on systems that only have a
> >  single non-polling idle state (like basic ARM systems that only support WFI)?
> >
> >  Before this patch, governors like menu would check CPUIDLE_FLAG_POLLING before
> >  deciding to keep the tick running. Could this change effectively disable
> >  NO_HZ_IDLE on these systems, causing higher power consumption?
> >
> > I don't know scheduling well enough to understand if this is a real problem,
> > but I thought it is worth mentioning it.
> >
> > Please let me know if the problem is real or not so I can feed it back into
> > the agent.
> 
> On bare metal, this isn't a problem at least in practice because the
> only available idle state cannot be too deep anyway, so stopping the
> tick doesn't improve energy efficiency too much and it adds overhead.
> 
> On virt, it may be a problem if the tick that runs in the VM
> effectively prevents the host from using deep idle states, but that
> would only matter for VMs running on systems that have deep enough
> idle state in configurations where the VM has only one idle state.
> 
> This is kind of under discussion in a separate thread here:
> https://lore.kernel.org/lkml/20260301192915.171574741@kernel.org/#r

Thanks a lot for the feedback!

Guenter

