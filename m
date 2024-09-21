Return-Path: <linux-pm+bounces-14530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F097DF12
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 23:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455A71F214F3
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7014A60E;
	Sat, 21 Sep 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB5fVd+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DF1EA87;
	Sat, 21 Sep 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726953791; cv=none; b=ZrVIEzmmvIQnoAXhyA52uwJwesJ7QUuN0cWfbjHKAn/evyOcAFUfrDPc8Fzc4qAqbWAYUoEDJ/iihQXz4eU8fwEl7rEvyvFI9wtPXybTnPCJXahhpNX9Uu7b6QJcEQyMolhEot/mejzaGdcPpJkFY58FwV3V4MtsBl19Dscjahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726953791; c=relaxed/simple;
	bh=Y27mv5c38W4VcfyPm5vAZA7hFlbgZOODQTnHSX07YwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJD9Q82dTPvDzxQk1NG7g1/62a/akjRiQHCI9/j31T0QeZD16A6UTme70Z3swgZTWPQ7/Tquhy62SmsrQrkV9tzqmvc+HQ1m/TWyLH1K63BfDvbRNZtDfewG5Y67dBSjAIWm4iTjW2rMuqCQV7iWesZvWX1vzXJ0UFyshDgttvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB5fVd+Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso2766815b3a.3;
        Sat, 21 Sep 2024 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726953790; x=1727558590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/xLtlfPfHuN+KQEVGSFjCi7DhUvsxCFBVvUZ5bRAQM=;
        b=fB5fVd+Y8NP83vfX4KT8DSA7zwAhgZaqCigPp2roriQz1GmD4F7L6bKhp9YFjm5oGM
         A4oFVY1Y6h7Bwe6MO4POV1VnJiSNms5ck3oqCBRfW4EyyYiA8kVuuookSK1CmKOAVQ2w
         MXs1wDKtYavHzGfuVlCyMCZ4vQR+P1X3vXH9OrgUw8nRcAjZWbcsMnItlrZ90Zo5GyR4
         iDZbZpXf56BiRtNobS4hClM1aDhqfEMwoSw1E6Z9xWLFJDqBa0OP6wFglMZXcw4Zp8nA
         JCyxXHQhEu6X4rKo6Y6V5dym3NjeSKSTryE5LRKVrkAlKIVRmta30qKYobJKMVkjjYMQ
         46wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726953790; x=1727558590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/xLtlfPfHuN+KQEVGSFjCi7DhUvsxCFBVvUZ5bRAQM=;
        b=vwDYMndiJhLA5BzupK4WEMi7YLpigAQBoNwp6zGlx5zbJVs2fxWBehC8MFi8zulYOd
         HBhYqM/W/JZ/VSmHnAGijGCiTTzjPgl5g4B38jOyxlM424XPB68jMm4SX3t0v5IUQMZ1
         MFjbcLcmo4A6tF1mclPAqzs7jxJT+G7WJcsnzMYomGkt5TFql0iDoHxwB3e1yybdjs9l
         Fv1YM9/jCPnitmAtLKvJxNLHp5oj/bKCfx5qp95LPajWN+be4dyxVxTvgqCJT3GfGxKa
         BVgL48MADE4+QIaE2NCKH3rHpZty3A9e3ulUh2uG4e5BUpuW7iKGOLllgc5GNLc6E90i
         gLgw==
X-Forwarded-Encrypted: i=1; AJvYcCVXDJVQxfhgxtOt1iNgbdMWQgCaepCZj9K+EKOCUp5cZ6adQIkguG9df7R/NuQaDc3/fdrPD5/hPkcKmTo=@vger.kernel.org, AJvYcCVoP7htZrTnvzMQ3omb+wHiA3C1r6OmQxZDOCX0Jhxa/9v7F6XPGjGul6AKtZxUOChC7BLcqxdeFhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL575D3X8q7wCjhdbXNU0KsonzdkPpTmWlT+s4qEhxYMHl0XXT
	T5gV95d+Cm8FoVCLDACBw6Z4YjQE34HRXPE0CduqK65yaWFGBqvZ
X-Google-Smtp-Source: AGHT+IGL1ObQO6Jj8+FQybOWawDU9oKiKJig9LlUWYAGxZdVNM27O38IzzjibtkechpjoU76swKjjw==
X-Received: by 2002:a05:6a00:3e18:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-7199cace840mr12479234b3a.0.1726953789610;
        Sat, 21 Sep 2024 14:23:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9756bsm11655870b3a.160.2024.09.21.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 14:23:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 21 Sep 2024 14:23:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for
 libcpupower
Message-ID: <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
References: <20240905021916.15938-1-jwyatt@redhat.com>
 <20240905021916.15938-3-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905021916.15938-3-jwyatt@redhat.com>

Hi,

On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go.
> 
> These bindings allows users to easily write scripts that use and extend
> libcpupower's functionality. Currently, only Python is provided in the
> makefile, but additional languages may be added if there is demand.
> 
> Added suggestions from Shuah Khan for the README and license discussion.
> 
> Note that while SWIG itself is GPL v3+ licensed; the resulting output,
> the bindings code, is permissively licensed + the license of the .o
> files. Please see
> https://swig.org/legal.html and [1] for more details.
> 
> [1]
> https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/
> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
> 
> Changes in v3:
> 	- Reordered patch series for cpupower stub implementation to be
> 	  first.
> 	- Added pm:cpupower prefix to header and Rafael to Cc.
> 
> Changes in v2:
> 	- Implemented the function so SWIG will accept the header
> 	  definition
> ---
>  .../power/cpupower/bindings/python/.gitignore |   8 +
>  tools/power/cpupower/bindings/python/Makefile |  31 +++
>  tools/power/cpupower/bindings/python/README   |  59 +++++
>  .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>  4 files changed, 345 insertions(+)
>  create mode 100644 tools/power/cpupower/bindings/python/.gitignore
>  create mode 100644 tools/power/cpupower/bindings/python/Makefile
>  create mode 100644 tools/power/cpupower/bindings/python/README
>  create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i

This file is deleted when running "make mrproper".

$ git reset --hard HEAD
$ make mrproper
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    tools/power/cpupower/bindings/python/raw_pylibcpupower.i

That is a bit more than annoying when trying to switch branches after
that happened.

Guenter

