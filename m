Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517E7269FE
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFGTlk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 15:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjFGTlj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 15:41:39 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 12:41:36 PDT
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9222102
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kSzGrhZeHHFA6vfrZ2LR8W+Xuz6bQ2NOc+2ymmMNnM0=;
        b=h76YaDkQ9KEY86SkBJIK7Zu4Enw0wNpHBcVhmUgBpVjydT2hAS48Fnof+OaILkoaBDq1/iv2MvciJ
         zFCHwPg6zxBLmjCVK1BOiWPQVAvcYJ1j2+T+aKRUj1xG8LbcxWtzm/CWEskimaYbT6ZDM5BH2jkIH7
         lTx51IzydhS8dOzNDsY42jQSYhHtemMvMZiA2KUS3Bqg3P+WgHnX4Hk0pEbysfuGF4JkfCrO5TMz50
         s7n8laMYfpl3dbdP2H3sV1/u76Zan9yUfQ1bJACzSxpks406V0+UvNp2GZnvf3RAlLlyxVyo5SBxO7
         fbuBjGDL7jRpFlpn29TGdyQNE+2YITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kSzGrhZeHHFA6vfrZ2LR8W+Xuz6bQ2NOc+2ymmMNnM0=;
        b=vboEswhlVEDQlrEBHy9SKyPCu7hxQ/FQGvK2EVLt3AfPI8xQHLCiCGcuYD0YlmIxPuNcTUIsJMfSB
         1ypYZxqAg==
X-HalOne-ID: 0f4d33df-0569-11ee-8726-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 0f4d33df-0569-11ee-8726-b90637070a9d;
        Wed, 07 Jun 2023 19:25:29 +0000 (UTC)
Date:   Wed, 7 Jun 2023 21:25:28 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, deller@gmx.de,
        geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 24/30] fbdev/core: Pass Linux device to pm_vt_switch_*()
 functions
Message-ID: <20230607192528.GA670717@ravnborg.org>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-25-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605144812.15241-25-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 05, 2023 at 04:48:06PM +0200, Thomas Zimmermann wrote:
> Pass the Linux device to pm_vt_switch_*() instead of the virtual
> fbdev device. Prepares fbdev for making struct fb_info.dev optional.
> 
> The type of device that is passed to the PM functions does not matter
> much. It is only a token within the internal list of known devices.
> The PM functions do not refer to any of the device's properties or its
> type.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/core/fbmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 329d16e49a90..f91ae7d4c94d 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1478,9 +1478,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>  		INIT_LIST_HEAD(&fb_info->modelist);
>  
>  	if (fb_info->skip_vt_switch)
> -		pm_vt_switch_required(fb_info->dev, false);
> +		pm_vt_switch_required(fb_info->device, false);
>  	else
> -		pm_vt_switch_required(fb_info->dev, true);
> +		pm_vt_switch_required(fb_info->device, true);
>  
>  	fb_var_to_videomode(&mode, &fb_info->var);
>  	fb_add_videomode(&mode, &fb_info->modelist);
> @@ -1520,7 +1520,7 @@ static void unlink_framebuffer(struct fb_info *fb_info)
>  
>  	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  
> -	pm_vt_switch_unregister(fb_info->dev);
> +	pm_vt_switch_unregister(fb_info->device);
>  
>  	unbind_console(fb_info);
>  
> -- 
> 2.40.1
