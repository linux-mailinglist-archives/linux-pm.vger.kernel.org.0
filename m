Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39371B0FEE
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDTPYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:24:16 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDTPYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:24:15 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7s1M-1jMgOK1FWU-0050zR; Mon, 20 Apr 2020 17:24:14 +0200
Received: by mail-qk1-f179.google.com with SMTP id s63so10975278qke.4;
        Mon, 20 Apr 2020 08:24:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuZsJt8Fl7eYK679DOTwiwgTO5eVvkPF9lLMDY8c/zPJPd+KoKtb
        bEEO5xVvJ0fIagRZzYezB1N7FkJh9M7SjT2saUE=
X-Google-Smtp-Source: APiQypJV6xCjJW3pYFBvIcq7CTKExcpEBGxZ7QSKktdgf68SWm1bP3Q+o1tJP+dpWf2jPXgW39nU0qV/m1IkXlbgPko=
X-Received: by 2002:a37:851:: with SMTP id 78mr16828527qki.352.1587396253107;
 Mon, 20 Apr 2020 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-5-robh@kernel.org>
In-Reply-To: <20200419170810.5738-5-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:23:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2BZLti5pLrru8s-45Yz54SA0JZbyjvYEstSDJZfnzEmA@mail.gmail.com>
Message-ID: <CAK8P3a2BZLti5pLrru8s-45Yz54SA0JZbyjvYEstSDJZfnzEmA@mail.gmail.com>
Subject: Re: [PATCH 04/17] power/reset: vexpress: Support building as a module
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1uLzFsu4G1E5Rt4bBLhftgIZmGhW65qqMpfzKQqVU/38E3qAuO2
 WeXlbPd2TDNyXTJUYhBBLr71S8VHi1kr+rNKFl3nJ4cNdYMCT5SGFRnyRfHeWWc13cbpIL9
 lu1XTD23rQKhu/PSFkl6aIC9fs4Pu7rb+fb7BokKj+tikNmcKZ28qUsF36LSem6eCVUCLAy
 BqQ+OW6B3LhTXGjjtrVoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tthkWj2ZtV4=:5qcjt+vXrCzBw7Dz/EU2k7
 P/c170SQL8QUygDqAJNqQb0UKlAvZ0MVurmejkwupvd7ZGOnjRNGV+mKxYrLDXxN+1PEOLU29
 kpN6yWLWWoPOjHqrjNkqVbnY0Vymr7eA60mPh3sZbqU9RVgwVdZHRJKs+6ptQtAO2+WvI1PEU
 IWjKw741LEQ2OIMiGGhgt0m9oUmEsZZO51HTG626mGvB/dZaIEbCSXKVtluSL6ylQmim5UVoE
 mzx0iPMGHA9A26LpG81FQhbvpJu0ijlCrWtEp7jc02E0wTefnxJW0RZGO03B78BgXDmlr3/aL
 UjDvM5tL8IMUFAnmtciJevb6pfoXUXVNPTkxdhT4UKLOPtCkn1hHDRrZypwdXEgkrxnDcrjye
 IiF2k/kuebbnC7DPl4AFJjRfbE++aLJHmwKiGbXx5cLgbwYDdWTLqYNteQNn4svaMDUo8tSxF
 xBKh1nRnBgRzJX3pNWnd7sxHVYKqAKY7DLF2VZVEMlkG9AQsCvmEoP3B9hsv6BO+UXAhxpnKh
 y3WNVHV1vW6pwuSnE4AqNT6EN4UQBgBgLUmMrWMCQbIuJhuAlHaaTc2BkNsgnPa3vnJOQ6z3O
 KIfqjmzmlxV6MyHQNghTCk5UZtv8ZrC09UsuLurlOyPfaOBP6Iv+ATQ0jd3EdiNu14M3e7hwe
 l0vqdMBo6aUSa3o0Gr1Kctrl51AS8xcurDKzymLyJzpLWnhR7EnnViGhxEf7SZiYjiAmK4oOV
 I0FIS3QBO4MSBeUaFQQkPHFzOOJQslKDOj8LHCdiIqi/QS5sK14QSbOXvqxbHCBHAMcMxkVt/
 dzJxWh7VXx7jzp8WIcW9QEtdEIrY0cDgkq524gG0Wuzoozk3SE=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Enable building the VExpress power-off/reset driver as a module.

Your change allows loading and unloading the driver, but actually
unloading is a bug with the current implementation, as there is no
'release' handler to undo the _vexpress_register_restart_handler()
function.

It should not be hard to add a release handler, or you could just
mark the function as non-unloadable by only having a module_init()
but no module_exit() function.

I suppose if you do the latter, there should also be a suppress_bind_attrs
flag in the device_driver. This is a preexisting bug.

       Arnd
