Return-Path: <linux-pm+bounces-32185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F1B214CA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 20:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C06B7AF9FC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E312E2DC3;
	Mon, 11 Aug 2025 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PvomAh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80892E2856
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937795; cv=none; b=c9S+2bX4YkxtQH7sUgxrZJMOOAmbzarhamGIpxB7zAt0RPzH3BBY/UaxaO/4hdOWY+5CLC4x0YZdi99zKBbU+BXUZTcrKvvt/a3rp5Q4bNPQAI9gnGu4+BDuuzpdP7+jeH+vGVgzrBNvXzMhFZF6g5AvxwrcYEokmrBFRRvCsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937795; c=relaxed/simple;
	bh=ehBzBrmpO6FFQHQkSJbU+IofYnPjC/m9CjtUMtSr3h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9HOOPuZJwmk5j5i+XbfJN2ef7X4XVkC1b7P1udIM8V4W/FZwJDaLyXeO9/NB0MsF4n6393/NzOuFlUVZkjgJ2/GeM72YMi3sb/RoUz/2l68eKck8S48AeqqWqsuZC9tQeNW7w8+iNxcpKUZGh2Cbq8hlHv3oVVplwximgBX63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PvomAh9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-242d1e947feso35265ad.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754937793; x=1755542593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMlOINz7dBI+CDnsCWZItvlMGoxrFbP7xNOE0bRZ508=;
        b=3PvomAh9dqdQ69rJTOSXAmlfxkqciRrRVQRopG0nhcWtYVTy9df6q57ktQiZBcuVAZ
         M2EoQuccX/x/jjt+AFz7KY7x0mnDVw1Le0JZptWzUxlj+fnulPN2pLGQLdfmPdwjaSBv
         D0kvdxkXYVN1eLRG2M+YlY6i4nr8q6In3pYebDYEYQ/jE7GYtjeTVC728cbOhKH5vm2r
         3obBivJIw4WUCo6O8zwE3E624GwZpvJJ+sNAbAWsZMZhHisshZkmktjlblB7adGIrczv
         1IY/aUVs9RbQFdlhBEABRHSukgHBvedFHmY8b96jqqWcx25xdTi0Ul/xmkpF+C0df4c+
         lNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937793; x=1755542593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMlOINz7dBI+CDnsCWZItvlMGoxrFbP7xNOE0bRZ508=;
        b=H1dFlMDcnhHk0uFJL3dk/noSOkMiy+X8GnuZFnvk7Rcp9vEj8GU2KckFfYN/wbh2b4
         DtBMk/Lr5b++u0bDE/ZFVrm3RcEU8v5XWz13mhWMygvg4AMVk8ZIc6simb3bjz9bSq2v
         XbR+OKUEHwIvP9eEJVNtqbhaTGZA/bOClLvRQDj94ecgpxfZIdyb38ELtzhASYOnfuXX
         8w1/jIn6rwcIfq2Ib5RiuFm84FOkS8x82jpP0VkQTihNd/xrtx0AucKzXeuMez+x4mSn
         EkRAPhyp5b/I9gJUFUW2k8Xe6RzrlsynEYYf1yxFKth4Wxr/pHGEnOHwbaKWT+Ujsvvu
         mqWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZtcDXWRnPPz329oWgZZyzpFGnznNUr8jTCtm5Grap+XPr4h4WMj+l1MlwIzuo8s6c5sxQXjV8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUyPBxBGPesvJtn0hKM+CeJsJK2eLFdZaYuEYsAsj0TT5rAUO
	8p+T25NswcXV3sOz6cIxAKKtUsJqveHPSeKaqTa47Nguep3cFdb1BcotjbbtkK/Plw==
X-Gm-Gg: ASbGncvXXwq0+/WnmX1DvsS9DC4vn4AfKUH87AY0VMZRX6nzVMKmLf1IznM9VUrQ6aA
	T70Hl8m6QwPc8LpDs0sxYZUq2sPKSvgNXhNCwL/8v6wa/H76+Bbxsl/2VlTNBcRo8QCadDcgStS
	sOL3eRlFozIoG+Xn02mGuFFwH/AWk2sFHZmUWxC1WtUAU234Wfrw9LA+1rp5YRQV1ZmzJkQOlR3
	7pe0G80qVv/xyMQKJX3jWwY2OjriWJACmDhDp02qB3U1EOqZGFK1N1nh9vbqck0FKs+whq+7TdL
	xfGhPES7wuqBh7nk+Gl9npW1OlZcIFHLHgxW4X7SrzZpBlmR9ZMtiCpRsaNwYVX15folwwu+ewW
	u/aMFnsER6vXFKhGGXRtu4Isl9LsyyrlIh9gySKmiono4bHuGDoy5zQ8jhgjUCg==
X-Google-Smtp-Source: AGHT+IFAj4RXchFFM1jNvlG+vT/TTAhPz8TKJKfTAJWiNhb+yc1od3gDo0I+qfsY9ggR5R/DTUlTOg==
X-Received: by 2002:a17:903:234d:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-242fd374f19mr359875ad.14.1754937792802;
        Mon, 11 Aug 2025 11:43:12 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611da39esm15268859a91.2.2025.08.11.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:43:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:43:08 +0000
From: Prashant Malani <pmalani@google.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJo5vP_mfBn_vxSF@google.com>
References: <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>

On Aug 11 11:35, Viresh Kumar wrote:
> On 06-08-25, 17:19, Prashant Malani wrote:
> > So, do we have consensus that the idle check is acceptable as proposed?
> > (Just want to make sure this thread doesn't get lost given another thread
> > has forked off in this conversation).
> 
> I don't have any objections to this or a better solution to this.

Thanks Viresh! Beata, can we kindly move ahead with the idle
optimization (which is this series), while we continue discussions for
the "under load" scenarios on the other thread?

BR,

