Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4AF6FA9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 09:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKKIVm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 03:21:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38239 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKKIVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 03:21:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so10186685pfp.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 00:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nfjsyq2Iq/Rw9u6HFg97pk+5ilhQojT1W/XVqRvMGCI=;
        b=l1S+sgbDmKwsK3KdNOInjmrTtKoY+QFQDoK3J7scMGzoRJETn4h+veC+eMcmkjUVDY
         7TcbMVC0WW70zXUr6CxwXO0/a7EWTyrhRj33bQB2MKWI38ScfJtAbMRYFkTrbGasRO/j
         D2w6pLBAW0eKonVrwIW4FpiEvML7zkecMmCIk7654QfSPF4lt7lbYP73wtTdAEY+mzmv
         it2vGHrGG+cA2Sf1s9ONhihNPk6mu0oBrWdQ+xzP5PbIKIvTM35NJsKmCb6+hHCKFZFu
         nLT9jM3h/o0EQ0Mxx3ujDl57b5zLhm3JAqtroSe9WhE9ELh2TlrZGERTV5IddKQ2cv/d
         AIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nfjsyq2Iq/Rw9u6HFg97pk+5ilhQojT1W/XVqRvMGCI=;
        b=o5BFkmRCtUmLy4yVvJ2hz79et+5HjipccX85Lrh6ckeXC1/mEz635sOsubZ25NChqe
         3qF750+lyKrfqKAzFfQbthQIUi4AdpYsVk0cKc2JnoK2SrEmZN2MBe4etokFgowvj8dh
         61e+6XVxbzm3SAh8+iKp4mnSFLqApUuRqsxnPm5D+VRbVQ4UCa1fTYSfk1bfembwKvO6
         bkax2ZlYVtyPtAvFl2qAhQx6nux69sGdP6C7T5N4hCRLFHNj/xgT+Jk9IfR+sn8CXaeq
         pTrhlEqYPmmaFSzFUmb+G9GWUQil9OpgH/7QJJuuIlLQuxSjE5V9786+wXxcvirjmLos
         +axg==
X-Gm-Message-State: APjAAAVLyy2teFPnWGn6nx0Ieq94QEGsZXmlMN3Pc0MnGIvzqFN67mco
        tHdp9Iw62a9nCPxB0R7wNlIO1w==
X-Google-Smtp-Source: APXvYqxbPpX+ZDuwq064KytIpco8Gqd8luDwvH9dqnhPt3x5p0nKMfogB4vWGZgRM01d07R/WWIyiA==
X-Received: by 2002:a63:d405:: with SMTP id a5mr27375485pgh.79.1573460499492;
        Mon, 11 Nov 2019 00:21:39 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id l62sm15251440pgl.24.2019.11.11.00.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:21:37 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:51:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
Message-ID: <20191111082131.ysngb7dfal6fpu2h@vireshk-i7>
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
 <20191018211214.444D32089C@mail.kernel.org>
 <20191021022516.gecunkpahu7okvm5@vireshk-i7>
 <20191028120133.3E85F2086D@mail.kernel.org>
 <CAKohpo=ky8FR4thsuW1xPnZrEW8zgXL0n4e+9rkRE0RLKKk1uQ@mail.gmail.com>
 <20191030143400.1680D20656@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030143400.1680D20656@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-19, 07:33, Stephen Boyd wrote:
> I agree a simple refcount_t makes more sense here instead of using a
> kref. That would be clearer.

I was using kref as I wanted to call the cleanup routine when kref
reaches 0. A refcount_t will have the same problem as the warning in
this came from refcount mechanism only (which is used by kref). You
can't increment a refcount_t if it is zero :)

Any other suggestions other than local counting ?

-- 
viresh
