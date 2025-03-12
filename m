Return-Path: <linux-pm+bounces-23917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60BA5DC79
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 13:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618D518994C0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997223F26A;
	Wed, 12 Mar 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQTv/2fo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531323E25B;
	Wed, 12 Mar 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782049; cv=none; b=GjqMECC9wB6947ttxfwmBKlvDS++++xzzzyplcj3EXteO5aS0xS8m1VAQxNVFhATNpCYKBQ9VpxGlfPaPGW0VJjas5vy6Bmef50Zpfya4IMGgUHOzKFlvpCTSufUqD2vVW0r0hSMkOMK2LpqCdwxPfPye4EU6iNK4cTzUPqugIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782049; c=relaxed/simple;
	bh=iCaOQg+bYjBOU5Pq1OQAzGdGXcYx1psBb7mPhAa+0K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai1bMcPaDSpI32DWO64GNdtM2eh8U5fl/xdZkVnZZhEtuDGHwQh4nK9XAflZ1U2xJgGnQwor+LQYlWGwfDSkS5daUWb6UMDUXDveDcKGEs9wn+UIARXkmFf4CNKHO/hyfA2KUGEdoF4PDPDBEOptcBg8RqaV30cG4B3mi6/Pzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQTv/2fo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so23333335e9.2;
        Wed, 12 Mar 2025 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782046; x=1742386846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gbJyQ9YMXQgDlI5KCMTybqsx65Et0NspyNdC3k3fNg=;
        b=DQTv/2fooOcevkkkEXBMN7eCyhhNDNXVlfaXfhxF9jJHvQG5HV6jQKE43YZfSTojnm
         oUccXOzCxk7fCv37Q7O47FWulVyf5rJH2KzBLVa2bMGiyPHxkTwd2O8RLlcar0LJ2ToT
         Fp5Uklu7MQwpgk3nHNmsQSeW8d6ulBh2vd1xxcaGDOdCmF6WzDGBoNz/KQ7t9QbYmmYb
         FccAxRyV0lIbFBKjv05S4nLeiV/25vGGF7Cg5d5X8uJV+VJ85uFdmU/QFMmB6ehwCEwI
         lu78BRj/MOAJCeevLlN0/nC6AYQtp/eN9Mv0zs5cfHsk8rzUQkvfBkw317AAiFb9Du1G
         7zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782046; x=1742386846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gbJyQ9YMXQgDlI5KCMTybqsx65Et0NspyNdC3k3fNg=;
        b=dTJXgg54zSrD9CWA836y502ZZqG1XBGJ3HUrJHjvgVJ/56TOjizPgP/s56nytgTGGx
         uF/NnA7eDRxg7liqzJ0CKRameANr6vxUbgeuP2PcDM/4RDqfSdpbLP5Toup06KfLUUwA
         LRzykBUGbshhRPVR2TVK94jAyD7wsKG0sC+N4YVkaw9zQZ8riUP0UwFzHR3OfcowT2sQ
         nqnglgXAypaB7U5gTWeMHkSKAhyvogbCo9lLb/Nr6jRWLmXIWdOEuAh4+52SabfJB704
         DI6CLMdbPAF2GUz0c4Lg7tNjkbiVg5rAFGkWnimKq2ZgTEr4DPmwTJJm8qMlt27S352o
         DW7g==
X-Forwarded-Encrypted: i=1; AJvYcCWOwL4TTuPDviKQP6XBximWi6x5EtkjyYKmltLeoZ0lzDKh0Jpf3/dEOII3Y5QDmc9qJfN9azqW1g==@vger.kernel.org, AJvYcCWgK9/3WnRmi9w6YkDPx4X9ycAf9UnRKkPh+hXeAfcqgOmTsqnavsC6Ssy7EYqSPUlVMqlGcjJ+3qOcSXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJKzA+byVjX2n6oBqctnsyBzG0PwiRrR4cQ2tWWBjDWGKdiyq
	hg7S6GmqWChEmE8F8OuPmaI+0YA1j038vxVqxJINLvR98YmnR5rWQ33uFtsj
X-Gm-Gg: ASbGncuHDqHAczNr0t4EbRqEl6cVno8UepNhzETQCSYFj+7wsdO0fwSrLNoBhgh5Bl2
	uEtCa3jCcfwFxaiOkFSHC0+NhAyyCSe7HDmu6jeIi5fUFzEhIiIqDYPIhjNn/yjolH0B7hiyr4g
	P/1md/i2OHCPeTUR26QhyItSBZhL0a0+f5xfJ4jbAiYReFSqX+1tLkwEp2oDtorOacwZUBUR/nV
	KDvYsojZ3A2tdbzgNNbMDhy98bHfAbrnhSa8p7y7pcQmNIXB5iuKlH+yQTbwHabGOTWESLTjmNC
	LIwlo8HnMuDryI4qQAoFd7n+vgGSonOLuGGicgpl9F/39xuLjEpqdIY=
X-Google-Smtp-Source: AGHT+IGOJTO8YcsGW1WxGpzrcahJlq10tOWKnOYX/Hfd9hVggMyWd0twwdyrB2fhLid804KrfY1vTg==
X-Received: by 2002:a05:600c:5112:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-43d04e92abamr57910245e9.8.1741782046047;
        Wed, 12 Mar 2025 05:20:46 -0700 (PDT)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a5f48a8sm20208235e9.0.2025.03.12.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:20:45 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:20:41 +0200
From: Sicelo <absicsz@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, pali@kernel.org,
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <Z9F8GS9DQHVEqT_j@tp440p.steeds.sam>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
 <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
 <Z88g2yBuRkCl_yAu@tp440p.steeds.sam>
 <b6xa7az5ohopf52ykp3quomkqpo5xmt2fratcmcw3efmkpa6nm@eth4wv4wm577>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6xa7az5ohopf52ykp3quomkqpo5xmt2fratcmcw3efmkpa6nm@eth4wv4wm577>

Hi

On Wed, Mar 12, 2025 at 08:19:44AM +0100, Sebastian Reichel wrote:
> Sorry for the delayed response. You need to prepare a follow-up
> patch against power-supply's for-next branch. Dropping the broken
> patch would require rebasing the whole branch. The only options
> you have are:
> 
> 1. Revert the original broken patch with a proper long description,
>    then create a new fix
> 2. Add a fix on top of the broken fix
> 
> Please don't forget to add
> 
> Fixes: f3974aca381e ("power: supply: bq27xxx: do not report bogus zero values")

Thank you for the guidance. I have taken option 1 in the new patch [0]

Regards
Sicelo


[0] https://lore.kernel.org/linux-pm/20250312121712.146109-1-absicsz@gmail.com/T/#t


