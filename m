Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668453C5ABC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhGLKS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 06:18:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3378 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhGLKS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 06:18:28 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNfZV4d0Vz6K5sn;
        Mon, 12 Jul 2021 18:07:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:15:37 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 11:15:37 +0100
Date:   Mon, 12 Jul 2021 11:15:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andreas Kemnade <andreas@kemnade.info>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <sre@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/2] power: supply: rn5t618: Add voltage_now property
Message-ID: <20210712111519.00000ef7@Huawei.com>
In-Reply-To: <20210712091130.2096cf23@aktux>
References: <20210705113637.28908-1-andreas@kemnade.info>
        <20210705113637.28908-3-andreas@kemnade.info>
        <20210711112039.43c4af7b@jic23-huawei>
        <20210712091130.2096cf23@aktux>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.8]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Jul 2021 09:11:30 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Sun, 11 Jul 2021 11:20:39 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon,  5 Jul 2021 13:36:37 +0200
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > Read voltage_now via IIO and provide the property.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > Reported-by: kernel test robot <lkp@intel.com>    
> > Huh?  Seems unlikely it pointed out that this patch was necessary in general.
> > If highlighting a particular fix in an earlier version, then state what it was
> > in the commit message. Note for fixes that get rolled into patches, it's
> > often just mentioned in the change log and we skip the tag because it can
> > cause confusion.
> >   
> The robot found a problem in v1 (missing depends on IIO). It is fixed
> now. The message from the bot tells to add a tag. It seems not to make
> sense. But probably the bot is also running on public branches (which
> will not be rebase) and uses the same message where it actually makes
> sense.

Yup. It might be helpful if they modified that message to suggest
commented format if the fix is rolled into an existing patch.  I've seen
things like.

Reported-by: kernel test robot <lkp@intel.com> # Fix something interesting.

Which makes it clear what is going on.

Jonathan
> 
> I will send a v3 with that tag removed and the other comment addressed.
> 
> Regards,
> Andreas

