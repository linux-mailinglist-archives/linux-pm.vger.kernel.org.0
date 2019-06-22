Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52A44F58B
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFVLuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 07:50:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44301 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVLui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 07:50:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so8275771ljc.11;
        Sat, 22 Jun 2019 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iNYX1eIR5m+yLL18gPgDNNyxPpPG7BFo26Nr+JmNscw=;
        b=FV4ftO1pfUvNlMpsH2sh1SK0iWMhaHK2SU+5VOS0YxyWiNZ70Tx1g8SCp/dtoI+oZA
         3z+JoNm8DJPWR/o07/Kd30GNGAwjXerSDUz7abmn86f3A27eLhMysYt4RXQG7LaAkBn4
         QrIV2jZs1zfrzZ5iJJ/23ulPaMAjSUMCIruH+l5eCsllZxSuLtanFE2Np+9SrNaqNlaZ
         Sd4rwUpGqEnjNx36AC6nMaB8r8sqwdadB0pJ9XWsDMmJrs1WmEm02z9ZIErLz+Qpi0VH
         GhxRHeDoblmkn0ZFIYo98GfX2M7Ca0842peXapnMFM9aQT2czs2ksilEBQdYsYGUmjAy
         D00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iNYX1eIR5m+yLL18gPgDNNyxPpPG7BFo26Nr+JmNscw=;
        b=NcCUw8j4Zs9/Ei/ww/9wDPsQ2SEFNYepxDJ98MkBwdRxzWyDajcRmo+1INdtbqTlM7
         9PnxhmXiq1lpF1gmWu5yP7It1bv06L2s6ifz1QRthIzrSZ4V2kMm1L7cH4aDVyn7fHyw
         0UPGCSYX7M5Ymmhvd79qo0zkf2hgiyEx/i4p3hWSfe8z1Jxj/xvzDTgWNpfj60RqzUlx
         M+3tb0VZc5Sg61OTpJ6ib8bk1wdA7dxwbpondYpagD1i+CL5AkKaKxp84RSvxw7x2Syb
         jSIYnpnVAFpKp3bM1XhJBYsX37KoeNjebctjNUUDIuEnUcNuYx2eBx+qG8Elk+FH6SIp
         ueGg==
X-Gm-Message-State: APjAAAUp2nypeFblYDaCXNhPfGhcLVbdUEeosF0uyRQwkGAqlZWTDwTy
        kfu006ThCOKUcQTVa/vo3CvxzTuuZEOJfSRrpoY=
X-Google-Smtp-Source: APXvYqyrU2tMldAVtXb0sta7z06ngrSEsWKZOUOF6rybBfWi+li5n48iifNHhaxeT8Tnx19UGDfiNu0tPoxtfzYJqXo=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr39505617ljw.13.1561204235917;
 Sat, 22 Jun 2019 04:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-3-saravanak@google.com>
In-Reply-To: <20190622003449.33707-3-saravanak@google.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 22 Jun 2019 20:49:59 +0900
Message-ID: <CAGTfZH18SQXj_2TpUf7iQPzWrZ5RP8-OCb_t6fp7qhuutGWz5A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] OPP: Add function to look up required OPP's for a
 given OPP
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Absolutely, I like this approach. I think that it is necessary to make
the connection
between frequencies of devices. But, I have a question on below.

2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:35, S=
aravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Add a function that allows looking up required OPPs given a source OPP
> table, destination OPP table and the source OPP.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 +++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 74c7bdc6f463..4f7870bffbf8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_tabl=
e *opp_table,
>                 dev_err(virt_dev, "Failed to find required device entry\n=
");
>  }
>
> +/**
> + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> + * @src_table: OPP table which has dst_table as one of its required OPP =
table.
> + * @dst_table: Required OPP table of the src_table.
> + * @pstate: OPP of the src_table.
> + *
> + * This function returns the OPP (present in @dst_table) pointed out by =
the
> + * "required-opps" property of the OPP (present in @src_table).
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OP=
P after
> + * use.
> + *
> + * Return: destination table OPP on success, otherwise NULL on errors.
> + */
> +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> +                                       struct opp_table *dst_table,
> +                                       struct dev_pm_opp *src_opp)
> +{
> +       struct dev_pm_opp *opp, *dest_opp =3D NULL;
> +       int i;
> +
> +       if (!src_table || !dst_table || !src_opp)
> +               return NULL;
> +
> +       for (i =3D 0; i < src_table->required_opp_count; i++) {
> +               if (src_table->required_opp_tables[i]->np =3D=3D dst_tabl=
e->np)
> +                       break;
> +       }
> +
> +       if (unlikely(i =3D=3D src_table->required_opp_count)) {
> +               pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +                      __func__, src_table, dst_table);
> +               return NULL;
> +       }
> +
> +       mutex_lock(&src_table->lock);
> +
> +       list_for_each_entry(opp, &src_table->opp_list, node) {
> +               if (opp =3D=3D src_opp) {
> +                       dest_opp =3D opp->required_opps[i];

Correct me if I am wrong. This patch assume that 'i' index is same on betwe=
en
[1] and [2]. But in order to guarantee this assumption, all OPP entries
in the same opp_table have to have the same number of 'required-opps' prope=
rties
and keep the sequence among 'required-opps' entries.

[1] src_table->required_opp_tables[i]->np
[2] opp->required_opps[I];

For example, three OPP entries in the 'parent_bus_opp'
have the different sequence of 'required-opps' and the different
number of 'required-opps'. Is it no problem?

parent_bus_opp: opp_table {
    compatible =3D "operating-points-v2";

    opp2 {
        opp-hz =3D /bits/ 64 <200000>;
        required-opps =3D <&child_bus_a_opp2>, <&child_bus_b_opp2>,
<&child_bus_c_opp2>;
    };

    opp1 {
        opp-hz =3D /bits/ 64 <200000>;
        // change the sequence between child_bus_b_opp2  and child_bus_c_op=
p2
        required-opps =3D <&child_bus_a_opp2>, <&child_bus_c_opp2>,
<&child_bus_b_opp2>
    };

    opp0 {
        opp-hz =3D /bits/ 64 <200000>;
        // missing 'child_bus_a_opp2'
        required-opps =3D <&child_bus_c_opp2>, <&child_bus_b_opp2>
    };

}



> +                       dev_pm_opp_get(dest_opp);
> +                       goto unlock;
> +               }
> +       }
> +
> +       pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src=
_table,
> +              dst_table);
> +
> +unlock:
> +       mutex_unlock(&src_table->lock);
> +
> +       return dest_opp;
> +}
> +
>  /**
>   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for=
 src_table.
>   * @src_table: OPP table which has dst_table as one of its required OPP =
table.
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b150fe97ce5a..bc5c68bdfc8d 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -134,6 +134,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_=
table *opp_table);
>  struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, stru=
ct device *virt_dev, int index);
>  void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct d=
evice *virt_dev);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, stru=
ct opp_table *dst_table, unsigned int pstate);
> +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> +                                       struct opp_table *dst_table,
> +                                       struct dev_pm_opp *src_opp);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpu=
mask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *=
cpumask);
> @@ -307,6 +310,14 @@ static inline int dev_pm_opp_xlate_performance_state=
(struct opp_table *src_table
>         return -ENOTSUPP;
>  }
>
> +static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
> +                                               struct opp_table *src_tab=
le,
> +                                               struct opp_table *dst_tab=
le,
> +                                               struct dev_pm_opp *src_op=
p)
> +{
> +       return NULL;
> +}
> +
>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long =
target_freq)
>  {
>         return -ENOTSUPP;
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


--=20
Best Regards,
Chanwoo Choi
