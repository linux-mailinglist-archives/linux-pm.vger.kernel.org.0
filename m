Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92F33C6FD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhCOToZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 15:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhCOToQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 15:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7AD164E4D;
        Mon, 15 Mar 2021 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615837456;
        bh=UAce/rGcdj2/yYhiWLiUo6Z/rclaCY8iTSRrttyY9Js=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iYuhGzFo37VYinzSH3h0VG2lzkaXa0JQ8P/+RyjgWBcasBEtjqWxDWUSsvub9WW1M
         xtwVlMTGuK4FsRr7mQ97N06nx+w0Q0kypFCxv6xCDu1byA9l6bW8mqg5Psq6DCMUoq
         muGhumLARaJbJDjjxN0+remrzFlpZpY1YJAaqGE+i/8f9UxOifl+GskcTx6oabN+fB
         w9PcbzYZkIZNi/o2JVjMxkpN1gHLzPKV+wUrWD2Afj+62aDbKjG3L4FvhcyqalFtFp
         HFMoc+FfxnD+aU/Xe0J81LVZT6Fxt0n7SwOMwuD9I4Us5YBFlbnBcSxb5xehrS96Fj
         05XYigcur4+UQ==
Received: by mail-ej1-f50.google.com with SMTP id lr13so68362512ejb.8;
        Mon, 15 Mar 2021 12:44:15 -0700 (PDT)
X-Gm-Message-State: AOAM531NaMSCLuHAB1gpppuBv4XOIDNJUdkifQm5W+yoAxeTuJiFCPdP
        Z7C8GfIQplCeozpSGKBzI/eewLOl1TpfXJdDKQ==
X-Google-Smtp-Source: ABdhPJwOS7Jdo9j/ce2nXz+gkKLZmvlJsRCR0zozStd99u3lWkjUNzfzn0f2xRfxZhJydPmR4YU5q2fU4n/Qp6eBQJQ=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr25581082ejz.341.1615837454425;
 Mon, 15 Mar 2021 12:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Mar 2021 13:44:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKL9VojmrygoARW6jSzBiyJDqBDjv-z8R04yf4VGdhhBA@mail.gmail.com>
Message-ID: <CAL_JsqKL9VojmrygoARW6jSzBiyJDqBDjv-z8R04yf4VGdhhBA@mail.gmail.com>
Subject: Re: [PATCH 00/38] Convert power-supply DT bindings to YAML
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I keep getting patches for existing drivers, that modify DT behaviour
> without updating the binding file. Let's move everything to DT schema
> files, so that this can easily be cached automatically by dtbs_check.
>
> After this series only three bindings are left unconverted:
>
> 1. max8925_battery.txt
>    This describes a node below the PMIC, which does not have its own
>    compatible value. It needs to be described in the PMIC binding
>    file, which has not yet been converted.
>
> 2. stericsson,ab8500-battery.txt
>    This also describes a node below the PMIC, which does not have
>    its own compatible value. The same applies.
>
> 3. charger-manager.txt
>    This is far more complex to convert than the other files, due
>    to the 'cm-regulator-name' / "<>-supply" thing. I skipped it
>    for now.
>
> I tested the series using dt-validate 2021.3.dev6+g38efe3f and nothing
> is reported when running dtbs_check like this:
>
> make -s -j42 dtbs_check DT_SCHEMA_FILES="Documentation/devicetree/bindings/power/supply/*.yaml"
>
> Also nothing is reported when checking the power-supply binding files
> like this:
>
> for file in Documentation/devicetree/bindings/power/supply/*yaml ; do
>     make -s -j42 dt_binding_check DT_SCHEMA_FILES=$file ;
> done
>
> This is also available as 'psy-yaml-binding' branch from my repository:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>
> Thanks for reviewing it,

Thanks for doing this. Other than the couple of things I pointed out,
looks good overall.

Rob
