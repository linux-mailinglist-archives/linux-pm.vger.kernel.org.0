Return-Path: <linux-pm+bounces-18514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FA9E332B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 06:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67EBB262BC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BED188737;
	Wed,  4 Dec 2024 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrJfiZ5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3E18C907
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290495; cv=none; b=E0gsAeEtCKk7G9WpEm5eBAEqOZTg23rQAhW22UVy0Z53NeJjEM7khLF5+fiKZCsFORbaJP3NBQNvWf0C07ISdWSJL+0SJllxGHZxiQFCdaRQ0MaRAfmCpG81DarXiYMNa1eNyYlAmYMGCZ+UISGIHXf38TsufG6HIrNI8Skpmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290495; c=relaxed/simple;
	bh=60KSuMbH6FJbeDv6I5bGxnhrCC3u+PsWw6p07DCkF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZB9nC3b3wCTF51Z4WxebCYj3WhBON1uuxdlfoCWYvJ28ZNlKLmJyUrofQrZpatRhtYTwTTz4xrolKE7WSysMvMNhzRSnbNV9xP+3cYP7JNbT2gVpcK9ikabTcGj/N5Nw0FaO4um4OrFEgWJdfTR09+xw/7zJQccsdxbYkOIdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrJfiZ5L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21577f65bdeso3945265ad.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 21:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733290493; x=1733895293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpAS+t1areb7EFucSGZBUfI2eS3KNM5K70k5cIEXvlA=;
        b=IrJfiZ5LUzrAYwNpi4hA1nvCctdopIUfFSzb3cn0VQu3jWuoJG2j0fMA0XuL6Mnn2T
         MhgDlO5r+1+JaVG0KlqcdMB7gkuacamDrtCntc5Bo/dj0+rprzDoVsZsruo768QiXK9d
         5ZcmtVLkBUYAMZ8lijhTxm89ZMsP+daUkAEHXrYrouC48YmaGt+YlFXcHAsx7LkezRWF
         JGLKD+6YHxmu3F9GiwBOSlVsa5kXDiPuhIs/RawaTw/b3efFq+axwnowVeUlfGgCwNh5
         FmJcJe8GsvBEEjSV76sj5nr3WZvl8wPpFFZqaNQbjYFUmppnWM5GpauyPitT+ekrxmTL
         RY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733290493; x=1733895293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpAS+t1areb7EFucSGZBUfI2eS3KNM5K70k5cIEXvlA=;
        b=ojwK8DKPRX6EL+n/yA7l9/QnraeJHjkX7QJkV6IgRihdbPujvak0OEh7g8B0+RIGYr
         7n0VCdDPMimZgcIDP/Yg3UIA9txmh/x+5l6P2G/zJXH1DyVZplotZF0owhsnlK2L+ukc
         3CueWkEhJ0diBDhX1wi+1uc/OWKWRZGUgFtCQysSm/gVPhqST5X3O2V7cXTtu84nHxWr
         NRN2JhQgxZQP4u2GmHC09lB8wXOGAeD+XqgV49Y9CuBN6O+O2dyYK+ytpb5ihL68bCB4
         sumHVMzbmkwJcyR6IYeTleq/q44s0SKiTSNZaYgebbP7RaW+2fgmZm8QTlOJrpQI3oGG
         oIjw==
X-Forwarded-Encrypted: i=1; AJvYcCWvVXRjrye3dzh19pb+CayHj/t0GNBmK6wg1P2TOw2dQOu4mMxZ/YuxgycsOk8XpgZVQ1H2XTK0PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzF0WjP2oG8RCiKoBkSwkWzADaatRm/fK4cNe2nQPd1Af2IAb5
	5P2NQXucEq/6RZ4TUYmpVsNND5fWoneByJmy1aNpi5yct83kM5HDdgbSPeL8YME=
X-Gm-Gg: ASbGncvbynP9iw7J15UcovbahdXwyVChP2w1T0vvOTHbB23orbvOMSZddahZH7uX7po
	5dmssWSbPIR8KPaP5f8bqtMqq/gf/pFfJSRoJWeOqXJQwvHdPeIHWr6SbWXuCYPfGXM6+C3Q3fW
	Ry01s5/mFJu2u8ljZH4qGKciR6M3FdvZR6uLcdY69ELlF1AumYEVnDZ7dbOvvykujRAQtioAtIX
	oWw0sPt6Sy1CK6ozTK2So73b8IBXqDeTGnX0FLh3esA9CvPrwtv
X-Google-Smtp-Source: AGHT+IEdnpORya0TLF8tZAX1V3RSME1H2AVwMfeTBLSah1wfAtXBdmItialQ323eREnRlYZm0uWy2Q==
X-Received: by 2002:a17:902:ccc5:b0:215:9d48:46f9 with SMTP id d9443c01a7336-2159d484a42mr153610715ad.21.1733290493127;
        Tue, 03 Dec 2024 21:34:53 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f627sm11823857b3a.64.2024.12.03.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:34:52 -0800 (PST)
Date: Wed, 4 Dec 2024 11:04:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] OPP: fix buffer overflow in indexed freq and
 bandwidth reads
Message-ID: <20241204053450.hw5eeqbjovwb6hlb@vireshk-i7>
References: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>

On 03-12-24, 09:12, Neil Armstrong wrote:
> While fixing a crash when calling dev_pm_opp_find_bw_ceil()
> because the bandwdith table wasn't initialized, it happens
> the index is not checked aswell for indexed freq finds.
> 
> In order to properly fix that, pass the index to the assert
> function and add a specialized assert function for freq
> and bandwidth.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Use unsigned int for index on assert callback
> - Link to v2: https://lore.kernel.org/r/20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org

Applied. Thanks.

-- 
viresh

