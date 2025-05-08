Return-Path: <linux-pm+bounces-26892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0FAAFAF1
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 15:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A946172F
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB80D22CBFA;
	Thu,  8 May 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Tkl66Hd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420222AE5D
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709819; cv=none; b=TBoMnscRW+FMYBgyLbDoipyIsxZbG6I7Ar27HcVmY7yK43PxLP5u/8HERxG0i+IA0CBelVTyA2m6N99UK/AauTIlyky3djvQ7cMUmhF/dpFJOEvB6ZGugzAe/t/L1EE6mqAwe41E1m7ETYlR4dvJAj4QKRj9oMbksmbAT8Q7B1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709819; c=relaxed/simple;
	bh=p3igjo1WeQ4ei3xNoOb2bq7IvOmv4IUIwEwUY8QYhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbWcWPi1ql5J1pZANjI5TEK3vyV85zb4LxgyMRurxsy2+OOAzlNPjDZF24Efw1KM453MjGefS6iN2Q+2CD76lztiWNiN6nzOaNe/i9VyattlKPyh/igKYZ/sdNrTcyqHNrdBy688FaHO30ZJKjUJughuXF8NiabDBg169tZcj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Tkl66Hd6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c53b9d66fdso132794085a.3
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746709817; x=1747314617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=Tkl66Hd6oKryphc9p8kkr1Mg5prsFBFUR3n6KnVt3T6ymlULM+JMCOV+Owzs8+hsFw
         VUEYc2HIjCByzjBSZHZUwAlqRKGNXlMMtaIHboI5dlOnnGkq+YAd8P3czzQbDIBol2fA
         zPYOsW/OcbdMNO158HzzUoozg5OxjfVAjduUsVOeHvHggdeezkilJ9h3zB+v8bUpPArO
         HAs5LbIatDvTh0HBkZwmJuMXmWzxpRA7e1pldYtwxRoDweXv/Oj9fhfOc3faJynREGTw
         5FhrlXY2ifjcb9esxqWwBW0kLa4DgX45VVS/6VQsS+r8ZBagKfp5Zk570XvJr4SsObBY
         FFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709817; x=1747314617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=YVVq3CpdwLyYi4T3MfT7G4gtia5g2w8NsuY+70fQAgOnv9JL8KbYEusMjLcHGEQvVO
         7PoxmfOAHaSdIeTLEIpFKN0DdeScuoQRVMN3RcfPHdCT5CrDEY478KXYP8uT52TF6nvY
         /qiIO5HtEsvZkGJuEfSvuzFgiz3+mcFi0lwlIApPGvgLO6ExhvHAUQR3HuQti94Fqzma
         WxAKhAmLCkOJZrU5xcpujTwvMUo6nHqkkjXmbTN3pjMKCSp84UUuK75AP+Np0m6lVS/6
         Fhy94kxnb89UmHJqmcrdyJCqu/ABjheRLtrysrDJ0Sc/g6DX8dePMd2OdhW+r1e9KVzw
         NerQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9k3NrFf8BoXN0iEM+1XSALVZlqVozbAsmZKGlfBU9zQPltp+l2vZ5QrsLysj24GDvfaz1brCPFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9oxRN/A3Ah02gfDoIExh6eIHzsIbj3K87rE9HW18NmG6sIih
	y7ODEK6EMTjPk4m0wb8R7AlXd/sTQAafmrVt88Dd+d39C1ayiiuOc7djNQvZGTvZAzh8iIoL3U9
	J
X-Gm-Gg: ASbGncsyNNtqvXIPDf/SIjn0mhu6XNn62kqAXYoqVxIheVxnOEo3VdouyXKt3V66zP2
	Iizl8Yj9APIvquIO9F5bE0wH5bILDlOJOfcPioGeX6rMBoUwVDdNt7PBeKPS7laX/rqwXaxLkRi
	yF9kan89YNLITtqKBQXVv/Otx2rgBpFv79i+deniPCzodLwW0fCAW17zSojM09YKIYFxk0aSgR4
	gD9rouCalMG++ku/hZvCPgWs1u8g3UWXXWjTu8vvlF0s4ra2Imy7DQnWGPJ8O/Z0miCGcVTR2XO
	efJoOsL68+bAe+PJHqgjJKz8EKa4/NBVF6Ej
X-Google-Smtp-Source: AGHT+IFc67B3rj29wLwGe5b9hNdUhbBaJDAFmOrgjOa9uQdS/eOlhjhIK4I5PRu/Z5lCJQDbW0IFWg==
X-Received: by 2002:a05:6e02:12ef:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da73867d6fmr68904585ab.0.1746709805765;
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945471sm3173148173.70.2025.05.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Message-ID: <0df727b4-c0fb-4051-9169-3bd11035d3e0@kernel.dk>
Date: Thu, 8 May 2025 07:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 6:52 AM, Matthew Wilcox wrote:
> On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
>> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
>>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>>> +		size_t len, enum req_op op)
>>
>> I applied the series, but did notice a lot of these - I know some parts
>> like to use the 2-tab approach, but I still very much like to line these
>> up. Just a style note for future patches, let's please have it remain
>> consistent and not drift towards that.
> 
> The problem with "line it up" is that if we want to make it return
> void or add __must_check to it or ... then we either have to reindent
> (and possibly reflow) all trailing lines which makes the patch review
> harder than it needs to be.  Or the trailing arguments then don't line
> up the paren, getting to the situation we don't want.

Yeah I'm well aware of why people like the 2 tab approach, I just don't
like to look at it aesthetically. And I've been dealing that kind of
reflowing for decades, never been a big deal.

> I can't wait until we're using rust and the argument goes away because
> it's just "whatever rustfmt says".

Heh one can hope, but I suspect hoping for a generic style for the whole
kernel across sub-systems is a tad naive ;-)

-- 
Jens Axboe

