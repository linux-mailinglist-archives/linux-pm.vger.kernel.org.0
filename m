Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2ACF8C5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHLpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 07:45:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730316AbfJHLpo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Oct 2019 07:45:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C7E77790C5E923CB0200;
        Tue,  8 Oct 2019 19:45:41 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 19:45:37 +0800
Date:   Tue, 8 Oct 2019 12:45:20 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] thermal-generic-adc: Silent error message for
 EPROBE_DEFER
Message-ID: <20191008124520.000009c7@huawei.com>
In-Reply-To: <CAJMQK-jawP2+Ba0AkquqU16vVnq_yGJN=Bepk7kLRusp_zdq2A@mail.gmail.com>
References: <20190910075907.132200-1-hsinyi@chromium.org>
        <CAJMQK-jawP2+Ba0AkquqU16vVnq_yGJN=Bepk7kLRusp_zdq2A@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 7 Oct 2019 10:07:22 -0700
Hsin-Yi Wang <hsinyi@chromium.org> wrote:

> On Tue, Sep 10, 2019 at 12:59 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > If devm_iio_channel_get() or devm_thermal_zone_of_sensor_register()
> > fail with EPROBE_DEFER, we shouldn't print an error message, as the
> > device will be probed again later.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---  
> 
> Ping on the thread. Any suggestion for this patch?
> Thanks

Looks sensible to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


