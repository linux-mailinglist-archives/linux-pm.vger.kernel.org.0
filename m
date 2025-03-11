Return-Path: <linux-pm+bounces-23842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C07A5C18F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F70A1896BAB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175FA257429;
	Tue, 11 Mar 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X0hm4EI7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FD2571BC
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696817; cv=none; b=XoUkfJzmdUbtVY2p/xpVRylrj8kxwy6IChIugjacvBU/k/psLbK9LJyt0sJJ9B7VuXEQd1jifwfN6gBbWNFusuoO9zW5t2S96Rv8iEQ5TeAHUqhoEcu+SX9czIUDid7sgdFS1AdG5SmM7+Yu8w/J3gNvM8FGwFxgVRZIjYhjaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696817; c=relaxed/simple;
	bh=eFLglormP4BRNTD9McBheIkazL8hunpP5eO6YCoRoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLHm4oN5Cko3+sZloKJ81MvdRmnJ4+sT1DUiovoVj2WSP4C4fx+5Z6vAHeZ/HUttoOOCPQ1O8FKp4bqLZZl/QXUijHUL6tXwM1zdUYw0iTv/i9p2Vu471JNk+fqN/kBbHiCP+ivpOvjiaBRsacB8jpYm27vncqYKj7F7BX7X9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X0hm4EI7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso31589785e9.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696813; x=1742301613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=X0hm4EI7PM4g/EBVtBGHE2kYgtPVj6vYqP0/VUrsQA1FSRTiojMeYsRNxAf61iPZLX
         mLSQS+mJ5FeiqKU0MEIuWNC8Yr8NbT9Qi0OZ5GAr67gbh0ocRTobC+qwZdqbn8EwFJ2D
         x2YAftG3oN68T220lo24HNP9Vc63BBl0jMF4m90ZnlbpOme0N5IX0VShW0MMlhodgCPI
         QMAOarzY8o06cQOtkh3w4EjWSSFigImIr+NiLxAJj7JwHlyuNbfongbuVSKXk/LUwMe4
         TAq2QnNKDFHOSOVNfLayZU6qLDrmECMsZufinD4gpE4hrKO0CSAauyRJNhzTW1ZDNJDG
         fspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696813; x=1742301613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=qAILF6qdaOrx/0sENuuKEi6kEkVHkqedpk43CTLpDPFmKMUVwM0Q6Wl+1lvWdLFBTS
         L7gyn9Bi9gnRy7t1nle6/UW4U9C8T24HYQNsVD+OofHd0ftKt42qkqlFAyJOoxstZEmg
         s4t6PuqCEeQcLHAdEr7IFV6Z9pPN5PGw/6qmPrH/w0YnrprFcwdjN5zR3uokxvicRkLi
         rN2HLViZ4okVnJ3Nu3Bm5PQ/2VlAsunMslEjUevqAg12OHPdsjitAaezaPLpIxgUofcg
         CiSmWMXxIZ0p7ytVeUhTVkrxyfv23HIMxXNHkDwVVy0GqqL/PHF5qZ+q2OwuNKmReXAl
         vbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqRMctj3cOel9ln6+w0iJmpMiBfWcZ3eBVVWAsOgEmiK+xPDfXc3noYSuBJBUosiaEHSyWI7tCVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZkY4pSeRs8gdoalXZUpHgtEP0p3o+FXKbuGnQWJWNVwRlkN2
	ebG5NrPLgSNYKo1QCuEAmM5EyIEnmbaY1ZrNTl+LHWRHN7AxgA4H1ybAEjerkbQ=
X-Gm-Gg: ASbGnctgyY8brhmLAebxNAv926S327DlsxbJtI9WbcQrnLMj/jJj9KCbwx7e+MmfzSZ
	10mCPFZuq0nL0Os9llYZAj4O9BEKjYDB4PyLT2lVQIYTlfY6m9wAFRdXBmZYTX5iLN8gEbyWx4e
	7YuE5B8h3SEcoxKTT7LV/T5OBDqh+vruHVS+vTRNmsmNmm8Jiv8y+UEkZXy5nMywQ71fTDsS5+e
	jJcq7nnre+ZmFBR8JGA7QzJ4fdPJL6/LTpClAiFEKZllxCNR6aaoSWvOKTNwrh8FqJYXdPpjI2+
	7UxSgxPWzuBH7H3FbOayFraVjtUKQGrIWKNSbUl4hJuMN3c=
X-Google-Smtp-Source: AGHT+IH+hqLaIb0ak3/PDp2FI+P/Br6EuYDT0bw+M1n8JTY5wRGCazId9C1SCJxp8KfNPqmCL4R8NQ==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr17143565f8f.39.1741696813238;
        Tue, 11 Mar 2025 05:40:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm17759906f8f.82.2025.03.11.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:40:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:40:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
 <Z9AShs1dEO0jrgjL@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AShs1dEO0jrgjL@pathway.suse.cz>

On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > Hello, I've being working on some patches that help to clarify the suspend/resume
> > of printk machinery. The last patch on this patchset address one issue regarding
> > suspended consoles and blanking.
> > 
> > This is a part one patchset that I would like to see merged before I send more patches
> > that will rework the suspend flag (a global suspend flag istead of per console) and
> > the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> > register the console instead of using this flag.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks good to me. I could fix the typos when pushing.
> 
> Well, there is one more thing. It seems that the simple graphic logger
> was merged for 6.14-rc1. And the console_stop()/console_start() API
> is used also in drivers/gpu/drm/clients/drm_log.c.
> 
> It is actually the code which motivated this rename, as already
> pointed out by John, see
> https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> 
> Well, I am going to update these two locations when pushing this
> as well. Let's just get this change done.

And I did as mentioned above.

JFYI, the patcheset has been committed into printk/linux.git,
branch for-6.15-console-suspend-api-cleanup.

Best Regards,
Petr

