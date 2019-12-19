Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B26126357
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 14:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSNVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 08:21:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbfLSNVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576761670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=M8ZLEXNh6zU+k+ikTgrVxJSdXd42PZcPDOw0npbcP9BJnn51YSeUxHqNQA3zQ5H+x29gPg
        T4qewjDA/Cs0YZZMSyqO57JJ9yC6hrMM3XPCA4QtRlRxiWJzf0hauTiaXGuN45D10SsN3z
        J14a/gQ94XA56ua32+OAWuWQyWqAV78=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-VVuxAuNbMg-CtqdyA0ZLtA-1; Thu, 19 Dec 2019 08:21:08 -0500
X-MC-Unique: VVuxAuNbMg-CtqdyA0ZLtA-1
Received: by mail-wm1-f70.google.com with SMTP id b9so1358259wmj.6
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QuhHETPe7h5O5S9p4/hJNro5uBVjObNxSM6kbHGs0=;
        b=g+YXAOMCgKg5AFvmYNJondolWdwOmZjB0JzRt/D8EER0lG0uDHN9fNCwYJMDxPtEMg
         KMc0KkReyb+X1IPTf//DHFkAdP0Z5hzvCjnTHtgAUnFZYWtgKwt64IOsX1Z20UilB7NN
         rh+cyBudGP9G+S+8VRw6M4UukHgTQGTdBrgM7Tjbay8K/qms7ycCSuUEvv66T8NYvgHi
         a4nypZPgulHVYr9uEGfHIPCnHrVmoVBp7Dj1aY32M7cItgV1oxLILrqZjlIsZsSbUFCV
         5Ev4P9/9Rwb2vz/UTHxddZHbS8A1/zz4er4Nv/dbZWK7xohl8h2y56UU87d3NhgVTk3m
         dM/Q==
X-Gm-Message-State: APjAAAV7gZ+ZniumZ4babjPvIN5cBMIfuYLwgJIQs/jUAxpE5YR4gEi3
        szo1k8qCRm2VUmGwHPViFfw4WFVWTNGt4fucUFR7VkaqthKcGw6NaX+F6HLqyb09CDwfxmV2JvM
        dJHh1hB7ZD3xRD0/uCKs=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922288wrv.269.1576761667270;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYsmkicq1CgpePFwwJNc2lMQupRm5P+aon/r1P4LvdWHpza4ghagzA9OygT/h18nUeOHn+jg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr9922266wrv.269.1576761667016;
        Thu, 19 Dec 2019 05:21:07 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id 188sm6488919wmd.1.2019.12.19.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 05:21:05 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:03 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20191219132103.GD13724@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2019

Argh! s/2019/2020/g of course. :-/

