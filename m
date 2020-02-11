Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229A0158A06
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 07:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgBKGeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 01:34:44 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50936 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgBKGen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 01:34:43 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so861971pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2020 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HGcC2OnO32w/HS2RDBKApvVUrcxu3cIrBuwc7D/gpYM=;
        b=bCpYck5a+TRFpLBgG9B/DRlll5qh+p0IGt9ss7xd3iVadm0WA7HpvHpe4DNVOJRoy3
         RI7Dgjz8mmL6C6daZ5lydmvwTRG0l0Fu9hV/cBO93v3Byg44mWEch1DztXqgMkpJmfFC
         fxOIyDMEBmyfXluYJlAxz8B5vMevc/diIpJiGhzRtyorAts2wVtkoOtpQc/DWhJjGaOM
         R28MyzLFkKan49o0jZm5NsBAZFL2KHJYhxj177L1zZgTkI3+1t062MdQ+sxjAII2wRNm
         UzRbmRFlVO+n6jUBnHbdLWxtorONHV5WawF7KTbpjxo3/lziIeYVamlblt0tV6oYmlXI
         n3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGcC2OnO32w/HS2RDBKApvVUrcxu3cIrBuwc7D/gpYM=;
        b=R2IsepkviXsQ3rmHPNgKJVbDemHGV8z6Umx8cW3sbGMSLmjNd23ynSw04xH7IitCxb
         IWX7RnyKnPrmtk/KKWZ6XSf7Y0ChN4gK6KV327y3JFE/VMW1KKfsp5s+iz0FKHNTSaZ2
         UNHBO3H/XJTVVkdwur5zFO/TXLNhLNLJeoaCaTmMBg8ZGtDmVwR3hm1qeAcD2gvngOoL
         rmuWWgGj9YOGkDZ2TG0r776AIFTwuSQes89akgEL4eNbwnUGfsTnNeNrQmIrAMCX3l4N
         iuypTCa6WQ040tvzR0VQiPSQo9W3BuagLm5OrYdzC9GXcpBn9UX0ZUDea32chQ0aejWR
         CEyQ==
X-Gm-Message-State: APjAAAXIyvQd691MLM42VmblmFvn5UWNo7avJ8haZJWYzRYaH2tYXzBR
        G8I+gt9666ftQAMnNav+mcb5SVlgf7c=
X-Google-Smtp-Source: APXvYqzP+A+Wrb3rddrLsAkf0bJsOeDu3DgqhgL6griYCa9cqeQrNcs+Pjg1ChOtQy/0VCbJd+4ULg==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr1929762pji.126.1581402883197;
        Mon, 10 Feb 2020 22:34:43 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id o1sm2744069pfg.60.2020.02.10.22.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 22:34:42 -0800 (PST)
Date:   Tue, 11 Feb 2020 12:04:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-02-20, 06:23, Andy Tang wrote:
> I am going to track to dev_pm_qos_add_request() as you suggested.
> Before that, I am also wondering what the factor it could be to limit the cpu max frequency?

One of them is thermal, but there can be others as well. Just do
following search in your kernel source code:

git grep freq_qos_add_request

This will list all the sources of this constraint.

-- 
viresh
