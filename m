Return-Path: <linux-pm+bounces-4476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5A86A1C2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 22:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099E21C27AD3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A314A0A0;
	Tue, 27 Feb 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJCSGHPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05E779F2
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069730; cv=none; b=hkd6crthYiO7DS8zjs3iyaR8ltRoxzwzNSMJv4zjVltcqeeLZE/DWYs0ZUe0Q10GBN0ud+FLM01oXnTSzSmCT4L/1hu6cslzdGfGVHdzqUgsVeCd4++Z+AYalzfu5G8qLcRhsnMLoaxrzfeVxnziMNkjPwKqzDkg9K0koCVNnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069730; c=relaxed/simple;
	bh=csIT1XHR4cYuY2ZsSpnmCH15cMwRUEP3bJuDCjtIZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDaydBqder3u7FnlGqdOCjUwjxa4BftMbd+f87gAAGSrfdpSVJFnVJEdc5wwav64333C6j3iPi5vkAp77yuCKMX3GYNzhIVLyrsG9ZcP9PNCvolci7Mb2N88hyY/JFw6gVTOJb7xWSosLCOKhz8eFBM4QOeb+uyxYhgvF1WIToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJCSGHPF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d36736d4eso2994843f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709069727; x=1709674527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbumYuQMoHK6ac8bBReSFLjXDGsDbGcW6OsZV5tI8TY=;
        b=fJCSGHPFXxTL6//LyJm8cYnlD5vnNxtkbu5+paiPnemRgS6tlmY2onR/FJYj3q4xr1
         K6CqG7k6PtQHV1vK7e4mNS0WHWms9Td6/J6rTFoKMXaj8uQ55VGc5Zfk1YGeKpMUv70X
         wVwF3X8xHIQg17pyaD48MIYJfkuNCCoIZpBxQv0bVrmWAAmSglY6diebDLmBkr0ElmGP
         ENuxuLKUeptP77l3y59WmB+Rwv6FfQjci+nVG6JLarAPOPaEjfBSBXzqPyr8ub1x9VvD
         osRvWVhEDuHTzc0tZWX98CAejpm249N0Bh+fLDaBLxjDLdobHAY/BFW5gu+2ZRklM395
         qXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069727; x=1709674527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbumYuQMoHK6ac8bBReSFLjXDGsDbGcW6OsZV5tI8TY=;
        b=NUbtP5nlXuhjojQbTaOfUmfMohPRd/Djrv2A0uuxVmn5zXX0xJNIZNY5ngKN74O6o6
         4iQuS3u8LuVYzGROFhj5mFSlZQN2zGHmPdp3RpWnpgtUPU1kNVLdjXU8RgrjJN0zyUVO
         fidHBYCIqwcrs/rBKz2LD9vcsbc3WwThXCDcyywOt3hEQdHA/r4yKRWAo9Hdx2S1QN+2
         gFlJ5FN6yRc8XHnzcy3lqru8e6k/RrmpeiH6VKQU8cUsghDv00CrePaTVLWnJ9rugNSL
         jpurF5u6kTiYzDWOl8xDuo1VsOhbNGktTMcH0y7Kms7E0IvoNY4q3OtzjB5qwNpKy6aF
         AiOw==
X-Gm-Message-State: AOJu0Yyj6rkIXoReFxJHfo+Sw8s0BS9COWOGHnYBJIF/P0UUPWJSRQwu
	pW/CV6uAVZqKBYV/iwuuj+YaUr0AuDnYf4oyiAER34t4jCvoBqhd
X-Google-Smtp-Source: AGHT+IEOA94dL1RXTSjAibvXUkmZzcmyLg5PsZZ+Az1vrQEo9s28UFECy0cFD6c3oZ+Z8VQuY/Fccw==
X-Received: by 2002:adf:fd42:0:b0:33d:1b69:fbbe with SMTP id h2-20020adffd42000000b0033d1b69fbbemr7803967wrs.29.1709069726961;
        Tue, 27 Feb 2024 13:35:26 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600003ce00b0033dd06e628asm9117941wrg.27.2024.02.27.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:35:26 -0800 (PST)
Date: Tue, 27 Feb 2024 23:34:54 +0200
From: Sicelo <absicsz@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH] power: supply: bq2415x_charger: report online status
Message-ID: <Zd5VflcLb3Es1xiJ@tp440p.steeds.sam>
References: <20240226194432.2174095-1-absicsz@gmail.com>
 <6slfmvqmtawwjlsobcfod6ewcjjbzmylz3owsdamdi4dod55wr@iiox5rzjj5ht>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6slfmvqmtawwjlsobcfod6ewcjjbzmylz3owsdamdi4dod55wr@iiox5rzjj5ht>

Hi Sebastian

On Tue, Feb 27, 2024 at 09:11:36PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 26, 2024 at 09:44:32PM +0200, Sicelo A. Mhlongo wrote:
> > Provide the Online property. This chip does not have specific flags to
> > indicate the presence of an input voltage, but this can be inferred from
> > the reported charging status.
> 
> The datasheet suggests, that you can get the status from the fault
> bits:
> 
> 011 - Poor input source or VBUS < UVLO
> 
Absolutely, yes. This particular state, which is a fault condition, clearly
indicates VBUS is present.

However, when there are no faults at all, then those bits always read
`000`. On a running system, one can check this by connecting and
disconnecting a charger (Nokia N900 used in my tests) while watching
/sys/class/power_supply/bq24150a-0/registers. Only bit 4 changes state.
In other words, the fault bits do not appear to be enough to determine
the presence of an input voltage.

However, looking at them more closely seems to suggest I should respin the
patch to also report VBUS online if a fault is reported instead of only
during charging and charge full states.

Please let me know if this sounds correct, or if I misunderstood your
reply.

Sincerely
Sicelo

