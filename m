Return-Path: <linux-pm+bounces-14626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10E984AE5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9211C22CA0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DA1AC45F;
	Tue, 24 Sep 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T72CeNn6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56841B85D2
	for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203023; cv=none; b=jMM8cjwpHV4QRuwFAXj+WkR1/pHxdiv47R3P1BRQ/C3dgAJoW1g/Ex9zHo8zZnHtUXqBhLKTfI+f9AlJuhH14/wMJhJyjO4wX6IFDvKboxvML3QfPgDV1DgyW2t+YSJ5BswswSL5EMajS97RMjldm9aYdQnwe6o2xXpnMe4PoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203023; c=relaxed/simple;
	bh=/G3umoy56yNrFR1GXH3xQAtby9UFyp5aXDqB4VLVtzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrP66QxXvrif4VzIDjUJgcMgvJj8rOutbQg5aI0js7oGxX8DRlDyrc4misXzSNj4Wua0KumUqUJM9/5dwsh8jEsVPJmEQkgy0wAggh5jouZ8TYFAHo2iSgmwIwfBMzMYrD4RDccOxIRrFzbn0SP9sY3+z9OGx8RHwzBUexIWiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T72CeNn6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so566095ab.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727203021; x=1727807821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwEeUkqNdXsH/r3E8ugcVO9XW2yFBZ93inSIHmXbaRk=;
        b=T72CeNn63Hp13lYbOMKZGL9LrQ/X1YzTeN6G1CDHpMTUtCoc8uOvMuNToRDbPPFU8Q
         QwdSTM3QWAGNzZmMG4v3QAYbX1SIMXmPEGmwBW/1G6eM/QkRH/JcTptAQbjvqYjOt8CR
         bhiZGThgUGoz8UmB4ORKV10VpJBCHqUSgXQc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203021; x=1727807821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwEeUkqNdXsH/r3E8ugcVO9XW2yFBZ93inSIHmXbaRk=;
        b=Eoeb1/dIdReic0OHl4muifYtzSKL0nf+N7HW6SJJVd+woxl2wYMebBmWaErxjClOiM
         oXdsd6MABYCNuaFiaODOiDhBaBM9qK9Nz0Q8nJ88zgbfI7jWFIPJMjoqM7jMEj11Fua1
         d51GbF+DwggzU5M4rH01zo/Tn98UETeV5wAoiM/pEYTIUByj/RS+Wisklul7m7xQRVbJ
         DIWMDZIF6Qu3lefVdHpHYja1H6TO4zNBFEWO5dX81yRBy/3qV7Lsu9hpKdHMqxbmoP2A
         Dmff8aWSoyCns5+iLtRYoGtXL19PPiQ8Eq9dV5IAKXpFL4Y9lkbo5Wf23op+Q022GVZG
         0VpA==
X-Gm-Message-State: AOJu0Yyy5oZvC7Wk3FlpuYaqoiw4P2MIfVuRDJqBpq6F4MdC1hpm7XJ1
	n6/mah0HSPT1jkLeRlDhTsXrctbO9gdClB16wCqPYTQkJMryky3M+9Ci/fj6gHc=
X-Google-Smtp-Source: AGHT+IEkYsamIodKjKtyWhebV89cW3T/O3IchT1i1x1O8h/x1+l17iMrMt62s8X+x0iR1ZKIGn2BSQ==
X-Received: by 2002:a05:6e02:1a64:b0:3a0:ca91:2b4e with SMTP id e9e14a558f8ab-3a1a2fd73ffmr30136755ab.3.1727203020946;
        Tue, 24 Sep 2024 11:37:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bd1c4sm554294173.102.2024.09.24.11.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 11:36:28 -0700 (PDT)
Message-ID: <ba84bf50-67fa-44b2-b73c-f219c277e38f@linuxfoundation.org>
Date: Tue, 24 Sep 2024 12:36:18 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Add documentation for some recently
 introduced options
To: Tor Vic <torvic9@mailbox.org>, trenn@suse.com, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924141747.6428-1-torvic9@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924141747.6428-1-torvic9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 08:17, Tor Vic wrote:
> The 'cpupower-set' tool has learned new options with commits:
> 
>    f2ab5557119a "cpupower: Add EPP value change support"
>    df8776b03689 "cpupower: Add support for amd_pstate mode change"
>    eb426fc6bdd6 "cpupower: Add turbo-boost support in cpupower"


Thank you for finding and fixing this.

Checkpatch complains about commit description format. I fixed them
for now.

This patch will be applied once the merge window closes.

> 
> However, the corresponding manpage was never updated.

Thank you for finding and fixing this.

This patch will be applied once the merge window closes.
> 
> Add a basic description of these new options to the existing manpage.
> 
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---

thanks,
-- Shuah


