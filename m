Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3621DB7A5
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETPDJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 11:03:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETPDJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 11:03:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KEvG3s045853;
        Wed, 20 May 2020 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=bP+cMvdzxHbOp4/kQJ7d2LwPqN/I8FVf/8zsS1gA1f4=;
 b=x86o//a+N7sUAMQyKvyRC0wBFiyV77EMWjWVN/dvnkhMVZ4wU4iVAn88oqMp84gAouIm
 keFU98X+h+UHkob/rIpEI6K69DYND4SSbrGkb7bRdR8/0zP8zKnc3XYVyevMHkrvb9Vg
 Tts6oGcty537eqVTExN/JdbCYxB57kwfu168GmTiQygzHYKa8oADoK9AokYdHnzu1DBF
 kevyPCKqY5YkIzMsC9EjXR7LOkIaJmcMqMUQCUcbLNHxVNfACqksLqoJZit+Vxfkganp
 0O26RwODFqFy0kd0uyZ2bdmoaDmTrgkRg0jFrG644gGIT3Q+uU7l3CKmtC1t7TEcJNe8 ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127krbntq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 15:02:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KF2fg2037820;
        Wed, 20 May 2020 15:02:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 313gj3p64t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 15:02:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KF2dcD010490;
        Wed, 20 May 2020 15:02:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 08:02:39 -0700
Date:   Wed, 20 May 2020 18:02:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance on
 error
Message-ID: <20200520150230.GC30374@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=1 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200123
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 01:15:44PM +0300, Dmitry Osipenko wrote:
> 20.05.2020 12:51, Dinghao Liu пишет:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > it returns an error code. Thus a pairing decrement is needed on
> > the error handling path to keep the counter balanced.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/staging/media/tegra-vde/vde.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
> > index d3e63512a765..dd134a3a15c7 100644
> > --- a/drivers/staging/media/tegra-vde/vde.c
> > +++ b/drivers/staging/media/tegra-vde/vde.c
> > @@ -777,7 +777,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
> >  
> >  	ret = pm_runtime_get_sync(dev);
> >  	if (ret < 0)
> > -		goto unlock;
> > +		goto put_runtime_pm;
> >  
> >  	/*
> >  	 * We rely on the VDE registers reset value, otherwise VDE
> > 
> 
> Hello Dinghao,
> 
> Thank you for the patch. I sent out a similar patch a week ago [1].
> 
> [1]
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20200514210847.9269-2-digetx@gmail.com/
> 
> The pm_runtime_put_noidle() should have the same effect as yours
> variant, although my variant won't change the last_busy RPM time, which
> I think is a bit more appropriate behavior.

I don't think either patch is correct.  The right thing to do is to fix
__pm_runtime_resume() so it doesn't leak a reference count on error.

The problem is that a lot of functions don't check the return so
possibly we are relying on that behavior.  We may need to introduce a
new function which cleans up properly instead of leaking reference
counts?

Also it's not documented that pm_runtime_get_sync() returns 1 sometimes
on success so it leads to a few bugs.

drivers/gpu/drm/stm/ltdc.c:             ret = pm_runtime_get_sync(ddev->dev);
drivers/gpu/drm/stm/ltdc.c-             if (ret) {
--
drivers/gpu/drm/stm/ltdc.c:             ret = pm_runtime_get_sync(ddev->dev);
drivers/gpu/drm/stm/ltdc.c-             if (ret) {

drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c:  ret = pm_runtime_get_sync(pm->dev);
drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c-  if (ret)

drivers/media/platform/ti-vpe/cal.c:    ret = pm_runtime_get_sync(&pdev->dev);
drivers/media/platform/ti-vpe/cal.c-    if (ret)

drivers/mfd/arizona-core.c:                     ret = pm_runtime_get_sync(arizona->dev);
drivers/mfd/arizona-core.c-                     if (ret != 0)

drivers/remoteproc/qcom_q6v5_adsp.c:    ret = pm_runtime_get_sync(adsp->dev);
drivers/remoteproc/qcom_q6v5_adsp.c-    if (ret)

drivers/spi/spi-img-spfi.c:     ret = pm_runtime_get_sync(dev);
drivers/spi/spi-img-spfi.c-     if (ret)

drivers/usb/dwc3/dwc3-pci.c:    ret = pm_runtime_get_sync(&dwc3->dev);
drivers/usb/dwc3/dwc3-pci.c-    if (ret)

drivers/watchdog/rti_wdt.c:     ret = pm_runtime_get_sync(dev);
drivers/watchdog/rti_wdt.c-     if (ret) {

regards,
dan carpenter

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 99c7da112c95..e280991a977d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1082,6 +1082,9 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
 	retval = rpm_resume(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
+	if (retval < 0 && rpmflags & RPM_GET_PUT)
+		atomic_dec(&dev->power.usage_count);
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
