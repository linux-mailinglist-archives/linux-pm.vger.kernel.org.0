Return-Path: <linux-pm+bounces-23782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C9A59E0C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66786188B6F0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AD230BC8;
	Mon, 10 Mar 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEMc2EYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459422D799;
	Mon, 10 Mar 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627621; cv=none; b=mEML8qnKLVpocMhXKjYgYmW2pMPb6T5Scw+j35kFccvyaU9DSESQlBvjLv89ckMCam8ngwKDXiAuo0AUzPN0NmSpTe6PXbaKm6ZNW1EwpnBAgEjHKSqK+rsqqbVkDr44T9NVZ0w0ZICAB9WBDSUwyHT+JuMD3viBNXDj2R9ZGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627621; c=relaxed/simple;
	bh=V2rzXXRqJrg2VQLAWz9UbOtWter9eLAmrrKUp0Vr7h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdHA35rhVSYrTLwdWuDeLlzDUl8wNiTEeAUhRNKWxQFqOYCxo7+/gSFgG4V5rt9Vf+MjiPrAncU41uiItQS4/qUVrQrk/HwNoTJFIQDvj5awFEGOLb/qfOJiwSJBkpF7DySlNolp4owNmPqaxRnJkzPzYWQDsXoVhHTR2ilxXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEMc2EYT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so5814527a12.1;
        Mon, 10 Mar 2025 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741627618; x=1742232418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OnYcFNhi5mdYOjgVvWpjisma4iBvxD3cgP4cZqTTfY=;
        b=VEMc2EYTpVLin/MC4A6UoG4+ttXS7PSHTWf7bOG/9UzDGVjdWMV0KoLsr6qxl15nop
         KLFv0egeY4ude0tloMDVMyKgcDs2IKHVhZiEti33tOrGZfe3rkTEy4beRTgzgCvHn6oD
         2iu90tSAsANPXf3abZvWWYeZGR6PgraPPb6vbLLnQxxWwz3EAaqpixauR6x+oN8XCQki
         BF0XpVjMG46XLpu8QGpM+T+l4gB5OSTfRj7OgXRmnt3uQcSX5TnqYUqhC4NF+Q8atZug
         OScNXD/UTX/CBoWugX0Vt1h4NzEv0lJwQLD17y1cs/pY4QoAIyLq9HZNIQx5jzKJDY7H
         PpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627618; x=1742232418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OnYcFNhi5mdYOjgVvWpjisma4iBvxD3cgP4cZqTTfY=;
        b=GzDxRg27E9uXVHltc7gJ2QBXy7WsEEk+Bx9+NkARuyK48qIhN14FPJfFLdHE5VRgoM
         Ci2iDFlerw7tm4NfVE9kf7gbVt+k0i8FPTyetve3M3adavM8Oi1ZFjhkUZwqRfT0ykJR
         nDXs7ett9UKan8Ul3LC8HCDTgYqdxY/J5IiZznSp898S6NvaXtlXIRC8qzO+w+s195r2
         XAgSjo2Ms1dMg5yc8q+T/JAnVbaJDRW+VVa7XtA0kmojp/2XrQnXKxCRRLZALGlLxUnL
         zSa+BdgqIL8Z7ogXym8zcBAmIK9ZJYCsT1CyJqL9UsnL/ocSjcR0RRPmhF/Qju55Sy6N
         oQyw==
X-Forwarded-Encrypted: i=1; AJvYcCVhdPNKBvHGSWy2SfZNVhXvSVXBJQZzsvfU+abpBiN/yxSHopqUbe8i9ckgBWwSkLlZeDdvyUFodg==@vger.kernel.org, AJvYcCXTLWpL4nGM7VTfBkmdacCN6J7Hnja6o4KPUlpQubknGXbxD+tCDbCmQGCEpW994U77t5TSjkm936cVIJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTVTeMUhdyRZlkAbnjhOy2IX8gJqZQFJyuJpFjnfIkj8cboYk
	rx2FQQMyPu5Y1etdxQ+GcuejyRsbl/WDd81/73ooUzCCYz9Rc+d+
X-Gm-Gg: ASbGnct+OaYohcHeFsfKHIa4CVUWU5MgJ7z1+OzCBWteSRj+QzlgI/J75TwSD9EdemV
	znHqLYHm2YbS3u2js4C8FPyHbtJT1euvSilLiEp+bVT1lH7plb4Zyh97wQi6uRuWyTJM1br/i1S
	wAT28a7vMSpiC3FuqP471b5NT8dgVI5pzuwbMw1ptk0cHPCWI7cqElyN6RvhSJYL9n0qbASjOXv
	9Pz00lZtX0a/iVlOZV1AL7WKlUfwlgsuoLREc7e/SvFoA7Tr0EAWUS0xlstM3czoitUDUB3/UCz
	glAQKqeofA1+4pFhbM4/19kRPJR3vMJg6YpQtAox3OkKefo=
X-Google-Smtp-Source: AGHT+IFOy8zOH7sXjAL34LP1z4OuQ2ll/9YwYtckUR8Zstq5U1gkyNd8ag1danBJdDwQrDKofXIoyg==
X-Received: by 2002:a17:906:5589:b0:ac2:6ba6:46fe with SMTP id a640c23a62f3a-ac26ba64e00mr1069312066b.50.1741627617731;
        Mon, 10 Mar 2025 10:26:57 -0700 (PDT)
Received: from tp440p.steeds.sam ([41.84.247.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a09ca468sm206335966b.5.2025.03.10.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:26:57 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:26:51 +0200
From: Sicelo <absicsz@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, pali@kernel.org,
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <Z88g2yBuRkCl_yAu@tp440p.steeds.sam>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
 <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
 <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D7D3E00-59C6-42F6-AE96-F04970D60E8D@goldelico.com>

Hi Sebastian

On Fri, Feb 28, 2025 at 11:01:35AM +0100, H. Nikolaus Schaller wrote:
> > It is in linux-next [0]. Not sure if that counts?
> 
> Ah, I didn't recognize that (and must admit that I did not search through
> linux-next). Sometimes maintainers close a discussion by telling that it
> has been merged.
> 
> Maybe Sebastian can replace it or recommends a fixup.
> 
> > I guess the only option
> > now is to submit a follow-up fix?

How would you like me to correct the bugs I introduced with the patch in
the subject of this email?

I guess it will either be:

- submit v2 against linux-power-supply/master or
  linux-power-supply/fixes (so the bad commit will be removed from
  future history)
- submit a new patch against linux-power-supply/for-next (so the bad
  commit will always be in the history)
- use a different solution you suggest

I apologize for introducing the bug and have taken the time to more
thoroughly test the changes, with help from HNS. I have the patch ready
now, and just need to be sure how to submit it.

Kind Regards
Sicelo A. Mhlongo

