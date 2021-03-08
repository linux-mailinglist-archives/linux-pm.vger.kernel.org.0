Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01C3312DE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHQH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCHQHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 11:07:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBBC06174A;
        Mon,  8 Mar 2021 08:07:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i14so3272829pjz.4;
        Mon, 08 Mar 2021 08:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rn8x35MBdfaxuWY4vKLKVWvEWISj7GhUlxtGzl6+yIk=;
        b=scyltQKAlpG1uzsADjn31nfWh9nszGFS+kfV4uzWjLA+LGcgJzMaSGk4wo1Ood2u7B
         xnoG2Mws6ltuN43YxvEwlaq7QDFzSKB9/LNKZzahoMqkhs4sdZ2No3ZsWz3nPyHs9xBv
         avi/XufeP2tzp7DmZPocATbm3QgzL2485fmXJmD9zIUomb+W7CkfzYvUKNuXcrDH+6TW
         XXDCQN38feWgYnm9eAelxk4zvGdYZL9mdkcHeiKPjlZKn1deS6GVh3LtrByUW3GvOnS+
         jjlpYGeTgbDXxbcLkGJIHodQzCpTINn7HrWL/0iVM08JsCc9KicQ1ubL4hNymnQwltyG
         J8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rn8x35MBdfaxuWY4vKLKVWvEWISj7GhUlxtGzl6+yIk=;
        b=f/5STeTvQlv2J9xGW+E0IUFV9KfxdiaP8f2yj51kHNg6ZIpKfrJlmskwnz2f7Mhgu5
         EDyjt5wmCDh+sxFMZIu1d6uULGneZDUB9G3GMnyLaGYnItLvfE2VsDeI9eoUWzSyWhQV
         ilMtoehMwwPaCTC/8bUGJH7EcWYIUhWYKQqSgc5M3B0hHdXAIZmVYa0MJ/+TFurX2K8o
         bSKIbepSHcOW9wC8Ul8PyOhOqjaNlWuy75fe4uJjt0vMmz//jyU80BdSYSyZR4yNme2m
         rrXcuxyd6lD8eXTdm9zSCgMGylv4nS4z6y3h8HWHI3g+0QOJQ8U7IJiqMjsMv+0ReHtg
         ZJog==
X-Gm-Message-State: AOAM532J5A7BYuRkmmKiRviic8Amk7aK2kX1nF0IVyz+r6K43tpyRmGt
        SWqi6DhgDvJ7oQtUf6hwrQgsmw6FnQs+QNYeJdc=
X-Google-Smtp-Source: ABdhPJwlETPEddEJcX2Prd3QiJHbpKgpOTn4l2m7041jug5qxRPIbIlZPu3CC6Rg9JLhzYfnTr1l0Pb2GvFCXwUfcdg=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr26560084pjx.181.1615219626473;
 Mon, 08 Mar 2021 08:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20210308152935.2263935-1-arnd@kernel.org>
In-Reply-To: <20210308152935.2263935-1-arnd@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Mar 2021 18:06:49 +0200
Message-ID: <CAHp75VcMAWFCOFEXizuOvDZs=qDSYndH=Y9RhgLdjb9547Op+Q@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 5:29 PM Arnd Bergmann <arnd@kernel.org> wrote:

> -       depends on EXTCON || !EXTCON

I stumbled over this.
What is the point of having this line at all?
What magic trick does it serve for?

-- 
With Best Regards,
Andy Shevchenko
