Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC6D22EA3C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgG0Ko3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 06:44:29 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41413 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgG0Ko2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 06:44:28 -0400
Received: by mail-ot1-f44.google.com with SMTP id a65so2794802otc.8;
        Mon, 27 Jul 2020 03:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZaOkG8tJhJqjaqbYAqGvBkapAn6ROJ6s1jbIuOwmQI=;
        b=H/PH9VW1QJzvc++LPUQOTTzh1QMFbBrMt63ECDQtIZVLRYfORkDO6aF5PxOtBBCPzG
         4TYwSUpN6BxATOnlXZ/E4gG5r4vMQmyctVyN7xjIF4o9Vhx8H8dRDRcLuvpuJo6DwnZj
         EZ0wR53doGV9vFsxs9BBbDiMFVlQFng81lfYcEj+ms8sqOJwf43YZgxr+tw8zJ4TmApq
         mue6zAKVGg47SMNS1oIMbDeGz7tXDF/T92jWIeMd3UDT78B0/O4DvhGH0pn5UKyLP2JZ
         XjMBRJ9urg1LMrpp9ICCclfLXFMIWEftvHEV34XF74HAzdh11MX7VEiHlUS5rdZ/9NwN
         ZtIQ==
X-Gm-Message-State: AOAM531btbbISfVYfA0kuPIX8Yi72ML1pyPK8bkutw00YgH0Xi78hLwi
        rt4nX2DaGEwvICTf86gMPYnyRvUDjWdU6CBzU9ojNg==
X-Google-Smtp-Source: ABdhPJyXgMr73gNh74MMSgGYUj/Np50jtjHXzMhQl4U64RXw2KdRLsGX5P8GfuiOAU1630MMIwOsaBncKnoLKdsGQlk=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr1718819otj.118.1595846667166;
 Mon, 27 Jul 2020 03:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <77dacd99-533a-751b-9c88-5fc03ddc29ca@linuxfoundation.org>
In-Reply-To: <77dacd99-533a-751b-9c88-5fc03ddc29ca@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 12:43:58 +0200
Message-ID: <CAJZ5v0iuuD0=9Sd2Mtzftn+HkcEzNCTzUk8bn-2Szvrss6iFZA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.9-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,

On Sat, Jul 25, 2020 at 1:17 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.9-rc1.
>
> This cpupower update for Linux 5.9-rc1 consists of 2 fixes to coccicheck
> warnings and one change to replacing HTTP links with HTTPS ones.
>
> diff is attached.

Pulled, thanks!
