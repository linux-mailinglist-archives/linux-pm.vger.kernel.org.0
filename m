Return-Path: <linux-pm+bounces-15366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA55995D74
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A970B2259E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08744C81;
	Wed,  9 Oct 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Q4hmK7U2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267C1D69E
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438861; cv=none; b=o2gU+MgJz7FBcHR0mljEGKb3DrrqqU/qrRqBdfnoNT/sLum3v8O8nujRcdv9ZHEsSvVNT/DFl3XLl4tBygZUx4zNglGl5Hxx4ouTyNBVhdR7USh/IO2QdJtrW1s71eBf9eYVU8JuRSgBxBO04oQIpKGnfstVIK6YAkseQZsrquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438861; c=relaxed/simple;
	bh=Uq0lml03fULgHRE27fxPp3bBnli/o2yLkTWNxaOfTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi+HdRhdM7YEDa8FVxQIFrE/p13bl0a6FnwSUzSzwnkPbNtpPJKm4PX5Z7M8VWF2WFfShPE0BrVbEJ9CS888VVP3rFkfkhccK6vdSEKUUnFmsZAtOd5jB09SoZPseA1s5oID33fptIlCcgRABBJsPTvGsxgwqgYTeSUnyyY44f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Q4hmK7U2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9b72749bcso529058785a.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2024 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728438858; x=1729043658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nqblj2vfGcWTCDBqYSGMN3UjaETKINHlT0Ae75jcL4=;
        b=Q4hmK7U229FY6RCijlFGyE+4BkGkEUH2cF3do60g9Csim13DeDPIUCPg7zPr5YeH1U
         AWm/3UAHoX77XRh6C9lsWSf4qruBjRqW/jBOMaYWOirh1B3TydH/h0RsTMGIl7OhHubi
         cl3NvSHqZw4iuTeCyvyg82xbxzuixd4F6F4kHutzTgh607pkb2m11AvYQo+yaiAsVQSz
         8DWTJgS/byCSNRVdymtIYJUoG2lVT0Nc44TROsoMfjDPzhBNi3mUl+nScRnq8XEfuaAs
         ZNj6ybUlQqKJdPg1LrU82dhN+mLFHNY7jL8J3BGuqi/QNrPIFZ4xUuPId/f0DK0pZsyu
         CheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728438858; x=1729043658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nqblj2vfGcWTCDBqYSGMN3UjaETKINHlT0Ae75jcL4=;
        b=GvFzzDhtIj0urbVrl+KRxudIyJBUWFBqj+QkJwUfbaXedXsS7hBPDkY9eLy3+uUoSM
         5B9QpDSZA3cEcPTRDgxCNRpccd8MjwhC9jLOEd/keXXXeVeR9wYQJFHr2ZubgiRy2/Nf
         dGV9w2WI82Tptwk/NAzjCuduTvJYBSM/pJnpK3K4HTatmuD+ndpAmZqoDrbqK86AtWvR
         feOj69Z+br36gF+cYFTH5DLlUl4Yz4yMo8ypcPIKc1qKoacZQWMHuIkcSTYzFxwGWm4D
         0TKWcn0tHXesA3uFKqcHlUsK2E2BD/HUEtIovj/pnv525Sp0OnUu5OQ77vKG0npM4ZL0
         XSHg==
X-Forwarded-Encrypted: i=1; AJvYcCW23plKQXq4VD1hhltuRONFP2jcs3tJgn9nYnx5/yG2b7qkMmoSgP8L5RLnhPjo0Yle8fzHTdG3jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwENpXxQ7B6FJ6szY8Tas9lWFvWyE0Rhp/uMCWtxV37jDOxBFgr
	x12pU8JqIjRnou2CKxANGbAIQr4TUB+61CtOmyocztTHTSXdv4LPRWuKPIfvuA==
X-Google-Smtp-Source: AGHT+IFMOAo/1I1cTdtK9SnWuFLYYRGtuH+Hv9k33WAPCEqzyYT8Pnv1I79nCa4g7DDoFJDtrRroFg==
X-Received: by 2002:a05:620a:4152:b0:7a9:a744:f989 with SMTP id af79cd13be357-7b0874a9aeemr119959485a.46.1728438858259;
        Tue, 08 Oct 2024 18:54:18 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7576497fsm412117185a.116.2024.10.08.18.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:54:17 -0700 (PDT)
Date: Tue, 8 Oct 2024 21:54:14 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	stanley_chang@realtek.com, tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <c0bda920-2241-4f50-8a6a-531ee9da4d69@rowland.harvard.edu>
References: <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
 <4b27a54007cbc50424662eba6b92cb22a7a528f7.camel@kylinos.cn>
 <0a4dc46ae767c28dd207ae29511ede747f05539a.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4dc46ae767c28dd207ae29511ede747f05539a.camel@kylinos.cn>

On Wed, Oct 09, 2024 at 09:19:39AM +0800, duanchenghao wrote:
> Hi Alan,
> 
> I haven't received a reply from you since my last email. Could you
> please confirm if you have received this one?

I have.

> I'm worried that there might be an issue with the email system and you
> might not be receiving them.

I sent a message 9 days ago.  See

https://lore.kernel.org/all/85105e45-3553-4a8c-b132-3875c4657c4b@rowland.harvard.edu/

You were CC'ed on that message; maybe you didn't receive it.

Maybe the topic of that thread isn't exactly the same as the topic of 
your thread; I tend to get the two of them confused.

Alan Stern

