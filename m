Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45F5643AD
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jul 2022 05:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiGCDYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jul 2022 23:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCDYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jul 2022 23:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAA0095B8
        for <linux-pm@vger.kernel.org>; Sat,  2 Jul 2022 20:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656818677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IzrLFcz7xBqCdvo/7PnEtIpQPNltkr3BlncC3DPef4=;
        b=LzCUNaMmF0lHPGMtL/1Dq1ReZeQNXliVvuCtT8yfjvIk2bk5xqc+dZIILX0SI7l6V9h9/y
        yFVRPlzpvTyjgPuptCmiEvWLgWGSy6UE3J3iwSPVJsgSaAIvz3okvCBfxwpx4oS/eNf9AB
        3N5q67xfD0GDuI3cyS+UOgiGKx7SAlY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-LPtzoe55OTimG0-O4-41Zg-1; Sat, 02 Jul 2022 23:24:36 -0400
X-MC-Unique: LPtzoe55OTimG0-O4-41Zg-1
Received: by mail-pl1-f198.google.com with SMTP id k11-20020a170902ce0b00b0016a15fe2627so2906606plg.22
        for <linux-pm@vger.kernel.org>; Sat, 02 Jul 2022 20:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IzrLFcz7xBqCdvo/7PnEtIpQPNltkr3BlncC3DPef4=;
        b=a14ugkr4gfWHoJLBEUt/GQl/I4M5aPd00EZmstLnCSwLKh+bVCmAAKnUWnDekpNiFp
         ZYmrZHJQR2b/ItvV6FYltzFyGB8bIJ46cnvrpfLi8hlWbkbFOKnakbnrs9EnRDNJ0mNI
         5hUeSgJZ7FTGZDkVhuHI8iWvl9Q8gbvGLjn6ZErYQs7Fk8b+Qrfz9OKu303YScnyIXYk
         Mkgu99+2+AmPPKJbBrnXovTZNggOnle5yF0Z8lg8eH/o7UHmoEBsZCUsK5x5vU5ZHghA
         6BJGAi5ij9UqLuNbS7Mg+zyzDf2wL2hjUwzrZO7o6jcxMbwDBUlcxouBi2vAJWbUgk91
         LjOw==
X-Gm-Message-State: AJIora+smGozLMBBvYI8tLidz99bH/Tjjw+y99S3LrpIX3bjjvKzQEHf
        ijqd9nPk9qk75Z6IztD/CTp+y1YKGoxV8kESWUFooa6UVzbcfqJcBMi4juEfm838wUyMEe+PDH9
        g0p0DYPiVBOGKN/bbbEwxU7exa0Hu44pbW4Y=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id m11-20020a170902db0b00b0016ba4ffc9d6mr19953509plx.15.1656818675337;
        Sat, 02 Jul 2022 20:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxWAzzGk8BdWUo8cnHPQsHGgJYMxLT+SlT7rBtH3p4I0U8J0vL+WBIokmvxxLrDxiPwn4FE8prjfSNaarDFBg=
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id
 m11-20020a170902db0b00b0016ba4ffc9d6mr19953492plx.15.1656818675055; Sat, 02
 Jul 2022 20:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9PPg7c=riv4OW9nTY_igFTNgX9Gm2a55ZAbVy+nB=LKg@mail.gmail.com>
 <20220701064409.b3uefcbipd5doure@vireshk-i7>
In-Reply-To: <20220701064409.b3uefcbipd5doure@vireshk-i7>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 3 Jul 2022 11:24:24 +0800
Message-ID: <CAHj4cs-mi6aVzDEo_=OjfE+aM+Mc74WYTWc9dp_MJJvUMiPdjg@mail.gmail.com>
Subject: Re: [bug report] lscpu: cannot read /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:
 Device or resource busy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 1, 2022 at 2:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +Rafael and linux-pm
>
> On 30-06-22, 19:37, Yi Zhang wrote:
> > Hi Viresh
> >
> >
> > I got this issue when I run lscpu after offline cpu0 on the server[1],
> > and I'm using the latest linux tree.
> >
> > [1]
> > echo 0 >/sys/devices/system/cpu/cpu0/online
> > lscpu: cannot read
> > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: Device or
> > resource busy
>
> That is by design, if the last CPU of a policy goes away we don't
> remove the sysfs entries right away, but disallow their access to
> avoid any races later on.

Thanks for the update, I just tried the latest lscpu, and it works there.
# ./lscpu --version
lt-lscpu from util-linux 2.38.237-8cdb3

>
> > I get your mail address from MAINTAINERS, I'm not sure which should be
> > the right maillist to report to, so only send to you.
>
> --
> viresh
>


-- 
Best Regards,
  Yi Zhang

