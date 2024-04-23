Return-Path: <linux-pm+bounces-6880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F5E8ADD5E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 08:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A082834F8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB93225D7;
	Tue, 23 Apr 2024 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRY0M8JK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041A21A04
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852779; cv=none; b=P4oe98cnW3Egqvtrg32dgdNwvWYNMfij5juUpFwwX3yAfma2jayS9fIb1ZelZcAtM2eQTcJvAUuAgttQs1reSuPs3XdYYt8baYaIHgr/IDcWGSiMj7Pk82iZbyrQzaWFNC3+3mFtJVf6QUl5TpzDDtelZx4tU6RExSS4DcO/KTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852779; c=relaxed/simple;
	bh=M2JXIn03F7/QSf+dBvEbYBl2M3pS0JqlWeKIyakpfqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz5l+OToUZX8VsPoEBelPytl1Wzg1jLKnofIYYGiOM1X+BiiO8Oel5LSmiIarPzYfM6eHD23Em00tR1PPa4bgiIxtAC3USoYCRa39byanGCclCpEI8r8RhbxFfE7ggReW6Re4ZYOp1foK0EvKEh3SIe3Y4YjozKUaaVam2r7Mic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRY0M8JK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so5118199b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713852777; x=1714457577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PegfXTHjFM9RFqoVlG6Hw8mcJ5lOawWkximGpqrPUKo=;
        b=VRY0M8JK1Mpdd5dXKWSenCZ+5FbYaalCKgfuAInlbur7zB5tC3VAsw+3SP6PBwwT1V
         uQU+op1k/eSIiweeGBuDukDxl3ipxrdyK+fim4yGK0azl/AwTvAuPPbHTXOlhG3Yvl5b
         5y7Xks8jqYXEkCwdgkvLuZ/mzFRsLuvoZLKPlRuOlpdTgrH3HRkSEBv7eELZ5Wy6evv0
         9sxAscHPmoGuA01x/Qhiql192qoDTYRVd1vWJrgnTLM9EV0xGS12q/X9dwBE3m5RXE14
         S+uv7oJLOoULF0D0FvcYzuXGhcSK2bMJAdBGIj4NkuJxXUj2H2tdxn7R5FZcWMVfAE0M
         0hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713852777; x=1714457577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PegfXTHjFM9RFqoVlG6Hw8mcJ5lOawWkximGpqrPUKo=;
        b=YtaUYAPyAWHVLxNaSvGhsIF3o5EWHlqm58Uq0qLJbQb+XYZv+7Ti92hSuwJWeM4Y18
         IoTfHqrqogJy4h4k3+e47LKAIg9NAVSyJVJtjQl4FWp24es5MDTAcETfkfse1SQDP9po
         MvC6ZanfggeN7IiuZsQyi46sesIL56MMS3ZDHT7BJgL3wnTnw7W3cmEbdraihZvoml4A
         t5vi1EZVMIjF4XJzbZileXuc1fBMaCSiiqXBjJ590Oq3Q7b8t2QJ+brbWlVNNO9BC5Wz
         tFV14ueHuBBY+8wsa7lKSP//yRaou9ktpVlg676GFKI5VbRG+PGgcWg+rAF35dS/ueGY
         LnoA==
X-Forwarded-Encrypted: i=1; AJvYcCUP6C1O+LLQLbGSNZT5T7UQJ55oVuvjkTH4sOwrasQ1L2ryeqprIzBZElil9JlabwAmZ/T/ZaySaTb+URDjRWoJW/1WFI4TV1U=
X-Gm-Message-State: AOJu0Yx+WxaaDaozasDdrJQGfa0j7+odwoa1pCX29I2u3p1LPmVExSJC
	3bPQyhzQLCq0m5NovmGgDNiLX9C+NKl7zs8WPRPwtDO4iq+BOLq50ZX7FyZbkoo=
X-Google-Smtp-Source: AGHT+IGUw/otBatPf+zILKW7L7JHzdCQoAVgJpbhjmlDG/lbtxa2H+ZKe1feDHWuNTXxbhpg0ZR54w==
X-Received: by 2002:a05:6a20:da8c:b0:1a7:ad53:d3a3 with SMTP id iy12-20020a056a20da8c00b001a7ad53d3a3mr17586950pzb.35.1713852776820;
        Mon, 22 Apr 2024 23:12:56 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id fn22-20020a056a002fd600b006edbcfe7005sm9139811pfb.144.2024.04.22.23.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 23:12:55 -0700 (PDT)
Date: Tue, 23 Apr 2024 11:42:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
Message-ID: <20240423061253.blyfuqasyiatm5sa@vireshk-i7>
References: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
 <CAGRGNgWHkVkOP13jh-w1KQYeR_yeq1JgOt9a+R40F8DGYKMtkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGRGNgWHkVkOP13jh-w1KQYeR_yeq1JgOt9a+R40F8DGYKMtkg@mail.gmail.com>

On 23-04-24, 11:38, Julian Calaby wrote:
> On Mon, Apr 22, 2024 at 1:31 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 30e5c337611c..cd50cea16a87 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
> >  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
> >  {
> >         int *opp_tokens;
> > -       char name[MAX_NAME_LEN];
> > +       char name[] = "speedXXXXXXXXXXX"; /* Integers can take 11 chars max */
> 
> Would it make sense to just set a static length for the string here,
> say 17-20 characters and add a comment explaining the number, say: /*
> "speed" + 11 chars for the int */
> 
> The string constant, while it'll probably be optimised away, seems
> weird and wasteful.

The counting goes wrong (I have done it in the past) sometimes and so
I like to explicitly reserve space like this, it also makes it look
cleaner, i.e. how the eventual string will be named.

-- 
viresh

