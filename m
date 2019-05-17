Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F119D218A1
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfEQMxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 08:53:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfEQMxS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 08:53:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so9263776wma.1
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2019 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcYe+aG05w2UO1ZXKc7jrJL+Ovz86Hm2R29bKoYuqSk=;
        b=rH+kGDRgLjtYMbwtzFJ/+HV77STlFFl9+9e0qxF5qNH187nZGa3EUzb5HtpMlZGFT6
         mckiPHYZVo2XqQmO1fByTS99DIzkCwIQ0iUbQ8XHGjZbhI8b5QBZtMCne7nKV7amcR/s
         w4+XsqLKG9SBEjX8GOUoBqoAhmgiF2hDtuTD8WHAsJ5S/xIfNjTMr7awPUo+K/bLURrZ
         qxFHpmXdAiB3O2i2y7SrnQ668XS/UyRoDj3aZAIPC8+B157NId4jYGjfIgIn1RCqE5d3
         rHQOIOyDVBQTQjLJj75ZTCKZMfEzs1y7e0ycrN335/0eP7kUTr/XM1F5BL47ednF4iBY
         QRTg==
X-Gm-Message-State: APjAAAVfAcnrPt/s914noi2vpl2+yVSq0FAXhZSGMSFWkw+lKcHCe0+3
        XAjnXHYdH+o9YhsIMmpV64khLqlgmgw=
X-Google-Smtp-Source: APXvYqzvQo4PLIOLgEYS45mThRlVYeoSKfB0i310BFOLRFwKSRuu+NOfl46fdrqxPtJzbnmADzwaFw==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr2040524wmc.94.1558097596479;
        Fri, 17 May 2019 05:53:16 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id q3sm6514366wrr.16.2019.05.17.05.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 05:53:15 -0700 (PDT)
Date:   Fri, 17 May 2019 14:53:13 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel III edition (OSPM-summit 2019)
Message-ID: <20190517125313.GJ14991@localhost.localdomain>
References: <20190114161910.GB5581@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114161910.GB5581@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 14/01/19 17:19, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) III edition
> May 20-22, 2019
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---
> 
> .:: FOCUS
> 
> The III edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Pisa
> (Italy) on May 20-22, 2019.

Next week!

FYI, final schedule is online (Italy (GMT+2)):

http://retis.sssup.it/ospm-summit/program.html

Live streaming events have been created and are accessible both from the
summit schedule ("live streaming" links) and at:

https://bit.ly/2Vz3yKg

Best,

- Juri
