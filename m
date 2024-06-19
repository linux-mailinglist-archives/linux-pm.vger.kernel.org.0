Return-Path: <linux-pm+bounces-9619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21490F690
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 20:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D3E1F21A1C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653C158865;
	Wed, 19 Jun 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlrjEVaS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAD158859;
	Wed, 19 Jun 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823480; cv=none; b=cCqUpSFq6Y/NiD1Ol52qq1BKOBwrow1q/WBvZLXVF7CcND5kkzYMgn/gskkWKtKzlwnzJpt4q1KmDXLSo37fMZPkhQFlUMaRmALVw97wDpQvczZ0/nT26WWoEv3016/wZx6O6ZU1Iq7fE5K+BJZLwSGem6/+NLDxVGp3fbIKlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823480; c=relaxed/simple;
	bh=S/i5GFI0C9CJiviOc39zgsIUOtMoI4rR7IhOp4KKGlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOdK/yGM29emnavSm9kyB7cEVTtlMS2BE9olHcNSq0q/SFqmVnuhnf05UJSYF7W54Fq5cxTlPqkMaHVafa+qLRBH+SkjGXq0Q6HAtL6H/iqXK4iaxCxurJvHCdJc60PldBP2MOosGfnuqzt2IcPeJCg7D9B8tyKG57zv3U4/HY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlrjEVaS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso97799a12.2;
        Wed, 19 Jun 2024 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718823478; x=1719428278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNFr4gjlFkmez4slphwi72YZdoWHOHUsWjmtkgawLZI=;
        b=YlrjEVaSxia0Vks8JBKxaek3HvRNphTl+KIdzdA4XfLTj2ujO8uVCPA9dcuDCXGgTS
         Cf54ZZUmwbYZaZuFNbk7RtvE5Xw2xPasmKQeDRdfAsIRfmmPFWBCLMU4dccuYcpHm9MG
         XuHjubYsijd0QXz+ODYURXEfDghKMgre9VrmyDIBG5JuhC+6RZzoQoEPCIh9BfuquZ/d
         pnquURwHbM6+K102uy2gqiVg8bMjH4pdcrzzh1d04c0A0mYBBYNsdLzKawisAuaRjzIM
         Bl4CUovqCbLu+J0J3OVW+xTNpKjjq2Ke3YIjw9cdfndW6vffqy6qkb5R1jAdDRkv4E5x
         x7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823478; x=1719428278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNFr4gjlFkmez4slphwi72YZdoWHOHUsWjmtkgawLZI=;
        b=k0g0ycsZ0tHhJsPhpL872bEQTaJ6kGQTkgvOpzNynU8D7BQ+pUFD6TANKGPm3oVrtl
         Smp0CAAJfHP66vT7XOi/n9318JmTdTVHPexuySNTOQVciSfa9eB8S/ofo9GpmeXWzzyI
         ijo+G5Je8NaE9wiLSNJbxDp3zy8WgE3MU1p5xgrAO19ek8RHTHVbmPfrBZKD27H1Uvuc
         gxa2e1HGxkHc3S81smejFLXhJDMc9rqH2AkdTVfoy3712H+bDt0BGAy3sP8Wgi81f5ka
         TqjdxN3M4Rej+ZlSqz8O6CySkNA9FOhiv1anVf3ktv40tnfXT7tNIeIXp06Yx0wDmmVM
         BsdA==
X-Forwarded-Encrypted: i=1; AJvYcCXOZZpDoQZGiwBfMMHU9V3/ADlljrwxBkxMBBZTWMYj7Bkl4DUibcohsD1kgdOPyNTVHBWkQoxQaomLzFQRClevbNXhyfsY3SOnIwjkZyPe81GnjFgBbr7Ay/hP89nplK3WG8HtrlI=
X-Gm-Message-State: AOJu0YxsD5k1nydHOEw8zTe2SadORYeQ7obsysaQ7P+UivpB7DNqOaMU
	nkLMGTdwgQ/4eflKU5XDt2WQTXcnfBUTXNgDYhAsyLNSv2Z6bIBJ
X-Google-Smtp-Source: AGHT+IGJ0WV5e2sIVPNXyt6/XEqLyh2MyoJXOZxUvVSz6bv2LV4c1qabtQYtWZ8dV693DXnj+2iIvQ==
X-Received: by 2002:a05:6a20:cd5e:b0:1b8:4107:ce3a with SMTP id adf61e73a8af0-1bcbb5d4c78mr3208567637.39.1718823477712;
        Wed, 19 Jun 2024 11:57:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2d34c38sm9969055a12.73.2024.06.19.11.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:57:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 08:57:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Message-ID: <ZnMqNHzCaAmolxkK@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
 <0c0073ef-3fe3-4c9f-9a86-5c42336b3da1@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0073ef-3fe3-4c9f-9a86-5c42336b3da1@arm.com>

Hello, Christian.

On Wed, Jun 19, 2024 at 03:07:32PM +0100, Christian Loehle wrote:
> > +	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
> >  	    !sg_policy->need_freq_update) {
> >  		next_f = sg_policy->next_freq;
> >  
> 
> Not necessarily related to your changes, but in case you're touching this
> again, maybe sugov_hold_freq() could be the last condition?

I'll update the patch so that sugov_hold_freq() is the last condition.

> And do we want something like
> #ifdef CONFIG_NO_HZ_COMMON                                                      
> else
> 	sg_cpu->saved_idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> #endif
> here?

I have no idea but if something like the above is necessary, it'd probably
fit better in the #else definition of sugof_hold_freq() or just move the
#ifdef inside the function body so that the common part is outside?

Thanks.

-- 
tejun

