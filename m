Return-Path: <linux-pm+bounces-24691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0AA776E7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8713A8C83
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92311EB5D0;
	Tue,  1 Apr 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnBhE9+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83A1EA7FC
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497512; cv=none; b=uAoISGxnH2VBEGJAXxTlSNg2TkxM94vizhOIEmosXTWqHylnU6j65Z4r9G+n5zakJx0GqDvUlBx/b1UZJLaFtOcjQCvL2mp58OxQaoTjMfvqZTpMQL2Nrx/8IVwVvLkLGvyOHTJqlv8qlnpLYzsfn8K9AzJh3pyeUFDfStRUgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497512; c=relaxed/simple;
	bh=x6eisvk2cJGS8K29x6eaCe7jHM1Q2xOlDzvGsCO0Xwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O51Js3isRUs0oTAD9KmnBWDOmR6ZN2DJ8dHvYnUgQzX6KeIVIJxEuz9CD/9mZ8FuAI1+gS5U3UZBwpBMmte2qJjiYxa9Tu8hulrSP2QZmDAoYc3NAB+k+2h1HaUTCQrewVg/AVlONGPoHahhahfU3m+qonadlHOJuFRArjHkReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnBhE9+6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2279915e06eso108252845ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743497511; x=1744102311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fimhb3OiftX9ZrPMTrOvtnWezcehgOg/R4ZHIiHVdAM=;
        b=fnBhE9+6ify8n0T0ac12yQ7f6tN/oWZjxod4E4myqEhc2p+nNATqixQpzY4otTeYSm
         ATWkG+/T8WFlA1tDosYwYDKc2PDP0nfEgg4GYratGm2VNAbOH9G0O+GF483/DMbnaioZ
         1tWlXLkLzzFpuzHxJ9Q/6AZH0a56MvUtqNtnMHhT9RvWXvMlF0xiZ5j0s+c1oCT2s6Z0
         qB67zZt/yVZjc9JZTIUebbL/K9ULzroYrCNSIvaIj5tprPa2G9K1k0U65I8AEoJqwIEL
         cs6qkXW032ctzmqHHTp1fCFlNr63rzoPA/tV333zL0kytUuo0QLoq9Vz0YKbzrFrnsVt
         afcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497511; x=1744102311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fimhb3OiftX9ZrPMTrOvtnWezcehgOg/R4ZHIiHVdAM=;
        b=FtACo0TKAkgo1kHAdA34zTblQuAxWzlWAV2vv5xtZn8+x26Rxmz7d/6JGG1VqENUKQ
         5Kkq4P49U/+j1nrw9jQtb2kqdV3XiGnnwJXrvm3z1PN9Is2PGBtRDwL8OWfdMAnVkMYz
         Giu+PaLq3eAUi1d8iEY4/v4MNhZpffH8gtky7jOZ95cwncd3TmYcWGuD61aPNDI7yc8s
         NX0UoUrJebGvkmZzyUzHboP8nXyXBnJx4ci6dh2jR2pKNqd+qkzoErVYn5SCPcc0/cEH
         jLgr4NvO+wuW7i6rmpV6j4WTU0Ov6xtNEdUcwDbJUT24YokA7U/jSCh8V+bXWQOEx8s6
         Xh2w==
X-Gm-Message-State: AOJu0Yz0d7TiL4TiAclhgQAaz/loaBHHfrIo3rHmFoYRRc0yFvLVYmBP
	6rb/yNloyLAxoMZhV26pbnW2ITNX+QHbn0vUVaS5KwS5y/0Y/rBJ/Vf7Ay1SuX8=
X-Gm-Gg: ASbGncv7i8UxY6IX+4dSznxC+bJo//l0i6CuKJFdq22HNDLyznsfucYpGXAQ4+/SAxH
	dU98wVbf7W3fuLW16cYfbFFanXRmyhXDXbSU4PW9l1OgX8ccMCswgGhnBnCw8vU+XiBgYDNkpCq
	nHmIptzWXo/nE/y2wQJlf7c/T9kLTdxv6OnRd+KsqKLg6XqlaI+wiMQY8BnnFghCTvA8pT154eZ
	z+8vbXm48NR1o2O1vm/hwSM/40JXV89VLe4/38plC30diiswTHFc+au3UO0wVI8rFDmBFJaqgFQ
	1Wd/xT9PIMyoSqzIX29eJgUbM1zYLIHDknjaIQxOLrxc6p/q7dfXa4/X
X-Google-Smtp-Source: AGHT+IEZWL2EWRD1CIAPFGd1IkcTOC2XDgPmTeYvR58PBkc2Qxqtz/Gc4AEcldb3r3efH6tSDVgjiw==
X-Received: by 2002:a05:6a21:3408:b0:1f5:8e94:2e81 with SMTP id adf61e73a8af0-2009f5c48f3mr23008466637.9.1743497510684;
        Tue, 01 Apr 2025 01:51:50 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b67de77sm7629402a12.14.2025.04.01.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:51:50 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:21:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to
 ->update_limits()
Message-ID: <20250401085148.xj5p6ir5lkjhgwqp@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <8560367.NyiUUSuA9g@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8560367.NyiUUSuA9g@rjwysocki.net>

On 28-03-25, 21:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_update_limits() obtains a cpufreq policy pointer for the
> given CPU and reference counts the corresponding policy object, it may
> as well pass the policy pointer to the cpufreq driver's ->update_limits()
> callback which allows that callback to avoid invoking cpufreq_cpu_get()
> for the same CPU.
> 
> Accordingly, redefine ->update_limits() to take a policy pointer instead
> of a CPU number and update both drivers implementing it, intel_pstate
> and amd-pstate, as needed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/amd-pstate.c   |    7 ++-----
>  drivers/cpufreq/cpufreq.c      |    2 +-
>  drivers/cpufreq/intel_pstate.c |   29 ++++++++++++++++++-----------
>  include/linux/cpufreq.h        |    2 +-
>  4 files changed, 22 insertions(+), 18 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

