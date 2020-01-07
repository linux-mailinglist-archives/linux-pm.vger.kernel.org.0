Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561BF131FDA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 07:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgAGGgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 01:36:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39260 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 01:36:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id t101so8811190pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 22:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tTZbqF4ps+HLBqOMSUsrvwOLXqstbl63mT0iHeyM9jM=;
        b=gIn750bJf524SYp9mT+vfcFuPZJLCQOYdp4DR/EX3JpLjbjtvN80SdzE/K5oP7F3Uj
         Wq5IMqbumPO41Oz2JlKJdMuY+5pGuUur99UCc9jfX+ln1z6jxKTF3L2jxeL7NDCv5tvr
         9xD5f68svYzmJ2DJApVOB4ZLpKh6SvL2vsa434c/ZPIZ8GSN08RSAy87fBc9RSkJUvO9
         3ion1e2VdkFljqrfdi/s/WB90VAVQmSrM5OzMxBkMbiS+1V1gfpuOFP/Nq2CAi35dUuK
         N1PyrzXZLKfZSgsPbWkwb9gKzEdD3QUhIaWPoUxdUJWJ+2yZDDJUTUqfP4DBZNl8HNR+
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tTZbqF4ps+HLBqOMSUsrvwOLXqstbl63mT0iHeyM9jM=;
        b=V5MK7Ke+ehBF/t6VWLeJWNGcSUdBY2Am8Nw0RDgXTsTOVfVq9/YizpNrBzxAZfmQtU
         t6h0ZZwJ2oisyjRAJ8hAXVqz1IcbEbu9KtajD0UyPruH/ejJ5O3E5TMgebSeSBHTBGVX
         x1qbwm2N29QrURd3dzMVi4WqDdmb7hoxUFcSWNfq+dj3v9bBpO+cIfucqLCXDF+lDRbN
         3nRSfUKvxAu92ms17PbKEyDixJGpPOitddEYGHpgtyibB6aOX8VoDuQK+a0tGdYF4uLx
         07SsKWObFXRAgG5O1CkrOuLqr9PfcKHPAVuZtpb/0LtkwaGTnmc6NvNZAOfRwgVPEGAO
         QS/w==
X-Gm-Message-State: APjAAAWxAMi8TUQwgxpdfyYhhEsj9KecwlBjyQtbiXzgAQZ00q8i/e1m
        /7xJ5omFmqXxdNvK22Sw9qOkwg==
X-Google-Smtp-Source: APXvYqyQ4bRJk5uq7MSi/mXacpXV5m3p/gkpAeQ6/tnMd4dRcssIsiOPw2AcqLSK3K4v0pCaqqLQhQ==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr47740347pjn.85.1578378978847;
        Mon, 06 Jan 2020 22:36:18 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id f127sm83164189pfa.112.2020.01.06.22.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:36:18 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:06:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200107063616.a3qpepc46viejxhw@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Discard my earlier reply, it wasn't accurate/correct.

On 03-01-20, 20:36, Michał Mirosław wrote:
> When parsing OPP v2 table, unsupported entries return NULL from
> _opp_add_static_v2().

Right, as we don't want parsing to fail here.

> In this case node reference is leaked.

Why do you think so ?

-- 
viresh
