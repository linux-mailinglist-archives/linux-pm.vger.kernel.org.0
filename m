Return-Path: <linux-pm+bounces-15572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEBD99B5BF
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6DA1C21B57
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D18199240;
	Sat, 12 Oct 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rFeMQl8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACF1946CA
	for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745582; cv=none; b=ryFmIwiYwUDt3h8RTblLHgdEm3pjVS1EARcjf1Ux+pBQwOLlIFrM+M12U7KuSbQjY3rqlU8WdhsFHhYg7/E14NN+3e5qlvLtU5Z8R6KNiuWebT9tc9gr9dzUIxZ8ijP+BdhjCo8p6or6jrimT2dIDDMuVCQzKV55F77c1KYXYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745582; c=relaxed/simple;
	bh=BFjY+9tjTvetqvmsSk1MQmSm+Ev3FqY5RW3ciHsvl6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKEVE/c3guZn27PUL+0Z8j7az2hZ0hxRvi7UM0+mcFQ/w3PTfjaQJ9gQEr9ClP9pEjqusPrp4GGchtNMHy5ghcLnIo1AllzjL9F6TGg6Kjt47XJpOj/SCJT2WMKfQixBi3VXHp0+oIanNG2jQSLKdLcEoG1HWuu2qQhAuLRi/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rFeMQl8i; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so24974976d6.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2024 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728745580; x=1729350380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NINyfAb50pmkBk+kkIj7HlbrUnyqF2VBG1K5cJtrRiQ=;
        b=rFeMQl8irS+yTLhr610XsGrbWtiP+DA2vz6eGXZC6x6sEyUUCg1g3GOo5s51rBtUGT
         nB6AKvXFnsj6R+NdRkF3zNpv97ybJQ4Od7eJJXuc9kfwpwJutkCNRnd7s93j/J0sTPzl
         ylRELrUvNRu1x3+dd724UQgNRUTUlqWCABtMnVKj7uYmuwHvDawj/ceGukr3om9zU/We
         i1+dx+c45UG3fu1r6pU6n+NwaNdjdkxEavgpY7o6ipZVm9spi99XIJCdVrRDz+KlBk+r
         kknJ/83hctWHQ7uCYnOham0/ENWzUPrjcvafKj6IIlIChwIkvpHu8S4UvHgsr59DYkeO
         Tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728745580; x=1729350380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NINyfAb50pmkBk+kkIj7HlbrUnyqF2VBG1K5cJtrRiQ=;
        b=ugsK8tP3yrkHlnAQWNptd0Kb1v9dryytD1cd7U8xN5TSiy7txKJtiCD8Pht/ZdBgia
         UVqYsjhahP80lODFF4n/K9UoME4imUidslZN8B2ZVPDigZfrLDEiViPzTsuz4nUayumg
         pfTH1KCOoYR6819Po0E/8ntMApKyJW9t5gj9bhHbvzQs/CecCjR2kiWb3YlYEoHKjqeA
         IjcHzLcjVVc0pROMNz6pZQ3vLjDMsM+sAhCBe3H99Cz8BvvCHNlQw+u2rVhIJcNDS5bK
         EoRXUTzFOywMDKKn54W1FhhKqm7UnfdArfmpzoCp6zNypHR2jLvY/zd49RvOyL0voQOm
         qZTg==
X-Forwarded-Encrypted: i=1; AJvYcCU6C+k94t8YagJMpTdQouT51FGM9dcJ7UpMqYNQnwfxzSm5qqLw41QLdFWu+r0r41ibsVDWGY3PJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPW3GGY6SEHN832uSdRVkWUXdl4RkXe0bPbw0EXVNYv8mbeWu
	8n45w0scM5awrdj83CE79hBy+ajU096LulRfP12nGCXCPM8YvBQhrFHEGrqluA==
X-Google-Smtp-Source: AGHT+IHrisRUB56YJBvz9UexR7H/m5FwaKEHSIsmCdbht8BvKNB/srOGvdRUwwwajZMX0P6PDOKkVQ==
X-Received: by 2002:a05:6214:5784:b0:6cb:b7ea:2072 with SMTP id 6a1803df08f44-6cbf9cb30camr42652966d6.1.1728745580035;
        Sat, 12 Oct 2024 08:06:20 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe842280csm26150636d6.0.2024.10.12.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:06:19 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:06:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Duan Chenghao <duanchenghao@kylinos.cn>, rafael@kernel.org,
	pavel@ucw.cz, len.brown@intel.com, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	xiehongyu1@kylinos.cn, xy521521@gmail.com
Subject: Re: [PATCH v3] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <489805e7-c19c-4b57-9cd7-713e075261cd@rowland.harvard.edu>
References: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
 <20241012094633.126736-1-duanchenghao@kylinos.cn>
 <2024101239-deprive-upstate-3275@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101239-deprive-upstate-3275@gregkh>

On Sat, Oct 12, 2024 at 02:40:01PM +0200, Greg KH wrote:
> On Sat, Oct 12, 2024 at 05:46:33PM +0800, Duan Chenghao wrote:
> > Co-authored-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> 
> That's not how to use a co-authored-by tag, please read the
> documentation for how to do so properly.

Duan, you can add my Signed-off-by: when you resubmit the patch.

Alan Stern

