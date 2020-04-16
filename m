Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA01ABCD1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502617AbgDPJdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 05:33:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440173AbgDPJdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 05:33:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03G9McWf035260;
        Thu, 16 Apr 2020 09:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=r9/Y7OZYuJr3hxhRbamTnKz46pCML+stvFIbGX2Fz5k=;
 b=DhTOlOYZTXWI16VmHoxh/we9dJYfwM/9pRAv2zrnzTXjDpMwEjoLKdooaSL5n+2fMnP/
 9qL9fijdvJkLKtwaClMj8tNa+lcOeD7h29fVUi7fD+BCGU5hrzbs4DJcwgtUSWm8z9ov
 tOrECfo7rACNob91dIHW7j26C7bKnrtKP0lWJeT+bhTVIqi8ooD6x0o38yCCGIQy+tZ0
 QCdOSUcoyUP9LwJbqp+QQxtT1c1oI/79Xu4U03Q0QHlyOOoCDj0jjEG3C4meGoag121y
 whnHp/YjgWiMLB/8pGVnIaWwjEUUTTp44heFfrRbs/wpi7oeNKhhZzgNYBJG1ax3lTLz Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30e0aa5ubx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 09:33:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03G9W6sW117861;
        Thu, 16 Apr 2020 09:33:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30dn9ev1nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 09:33:09 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03G9X5nu032592;
        Thu, 16 Apr 2020 09:33:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 02:33:04 -0700
Date:   Thu, 16 Apr 2020 12:32:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove redundant assignment to
 variable i
Message-ID: <20200416093254.GL1163@kadam>
References: <20200415224010.1564330-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415224010.1564330-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160064
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 15, 2020 at 11:40:10PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable i is being assigned with a value that is never read,
> the assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index ab19ceff6e2a..abaf629038c3 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1003,7 +1003,6 @@ int ti_bandgap_probe(struct platform_device *pdev)
>  		ret = ti_bandgap_talert_init(bgp, pdev);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to initialize Talert IRQ\n");
> -			i = bgp->conf->sensor_count;
>  			goto disable_clk;
>  		}
>  	}

This isn't the right fix.  The goto is wrong.

The "i" variable comes from the iterator of the previous loop.  When
you're unwinding inside a loop then first undo the partial iteration
before doing a goto.

   979          /* Every thing is good? Then expose the sensors */
   980          for (i = 0; i < bgp->conf->sensor_count; i++) {
   981                  char *domain;
   982  
   983                  if (bgp->conf->sensors[i].register_cooling) {
   984                          ret = bgp->conf->sensors[i].register_cooling(bgp, i);
   985                          if (ret)
   986                                  goto remove_sensors;
   987                  }
   988  
   989                  if (bgp->conf->expose_sensor) {
   990                          domain = bgp->conf->sensors[i].domain;
   991                          ret = bgp->conf->expose_sensor(bgp, i, domain);
   992                          if (ret)
   993                                  goto remove_last_cooling;

So here we should do:

				if (ret) {
					if (bgp->conf->sensors[i].unregister_cooling)
						bgp->conf->sensors[i].unregister_cooling(bgp, i);
					goto remove_sensors;
				}
The line lengths are long so it would be cleaner to say:


			struct ti_temp_sensor *sensor = &bgp->conf->sensors[i];

at the start of the loop.

			if (ret) {
				if (sensor->unregister_cooling)
					sensor->unregister_cooling(bgp, i);
				goto remove_sensors;
			}


   994                  }
   995          }
   996  
   997          /*
   998           * Enable the Interrupts once everything is set. Otherwise irq handler
   999           * might be called as soon as it is enabled where as rest of framework
  1000           * is still getting initialised.
  1001           */
  1002          if (TI_BANDGAP_HAS(bgp, TALERT)) {
  1003                  ret = ti_bandgap_talert_init(bgp, pdev);
  1004                  if (ret) {
  1005                          dev_err(&pdev->dev, "failed to initialize Talert IRQ\n");
  1006                          i = bgp->conf->sensor_count;
  1007                          goto disable_clk;

This should be "goto remove_sensors;" as well.  The i assignment can
be deleted though because it already equals bgp->conf->sensor_count.

  1008                  }
  1009          }
  1010  
  1011          return 0;
  1012  
  1013  remove_last_cooling:
  1014          if (bgp->conf->sensors[i].unregister_cooling)
  1015                  bgp->conf->sensors[i].unregister_cooling(bgp, i);

Delete this partial unwind because we moved it before the goto.  Say
we add some more error conditions at the end of the function, then now
we can add more labels and it's not complicated with this partial
unwind.

  1016  remove_sensors:
  1017          for (i--; i >= 0; i--) {


It's slightly nicer to write: "while (--i >= 0) {"

  1018                  if (bgp->conf->sensors[i].unregister_cooling)
  1019                          bgp->conf->sensors[i].unregister_cooling(bgp, i);
  1020                  if (bgp->conf->remove_sensor)
  1021                          bgp->conf->remove_sensor(bgp, i);
  1022          }

regards,
dan carpenter
