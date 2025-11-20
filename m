Return-Path: <linux-pm+bounces-38306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A0C747B7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFE394EA371
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE6346E6B;
	Thu, 20 Nov 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhaPVNhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4713376AC
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647729; cv=none; b=qt8VKQ8Zq9BEVFWGUgYRImI9hZZnBg+g6RlVUU7Cr8jj9OxqN2mPqgxNRrGDPgsaXa64RdUPuf4xiksbV8n/xbI4UPCr+BPRVKiObj5dYVqK/4VRoFvPgkO1ngIsobyYqtevY++hzLKuCEzMExt4ZZtMO0bnDrOUTIuHJbuJhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647729; c=relaxed/simple;
	bh=hXBBthJypM5vjTTphA0r6Oi5jEFjwOHaRtvgMSwE0wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB5T9+iIliDjB6bzvM0By1GFF31uoYYe3RXU3Aemq0GAEm6XDriy6UOwS2H8LTwboEJ9VTpV/gO0Osp4MGkzXdV83BiS3jfq/QfTnpCseedizv+yMYNmemJqo7PgFcEfFN6pmjjjcU7iWNA6k3b5uxkAfQfOEgcv55EpjWl5lPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhaPVNhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C9EC116D0
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763647729;
	bh=hXBBthJypM5vjTTphA0r6Oi5jEFjwOHaRtvgMSwE0wk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UhaPVNhu09owXU6y9W2n4EbDbqwc/M9mp92cn9ldwz/kHaQSikV4QEb1x8h862KGJ
	 XEAlXPX/rZMIk4ZA/MYwmG9EU/RSiyYSX7pM56WL3cf1WqwvDKTFeYvROl6ruiKiWz
	 RggNxFAtFsx+/iyPnygo4X7mkYvb76H07eNlxXYTNwF9wiCoIR/FCK1rQOFDN8Pz89
	 ulOQwlOIztwO8KonkDga5rm923zYMQC2dcj4b91fvXFtiMLAZ6U7ixUJeqqReeRjA5
	 G9fse4dfN9owLuSRdXtpyoUOE6rOkvVJcpFyUykgCDV57nRS6GoyWnsS0rOd+YyS/e
	 x1GT2S7aSmTzA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso1639064a12.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 06:08:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjjGX5Ut/Kiymg10QmXlrE0cs5BOK2LkylM/I+kv+PqjxlYSDZvAXktxUMBNo+owjc6kpuwRB0mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Pt0tCyefuE5TLk7h8JDt+QlaJwJZuYKPW19gr71d0ZYfRxz
	DAZQUjamk0cuvmxEtBvwCHNVr1/zWHNhb9EmCAeNIDPKPxVhDr+FUr1CZVxkYQ6JmI8/cdAaExv
	aD5tuEhdlgpbnPHjF2+UG7OxMUwuw9w==
X-Google-Smtp-Source: AGHT+IFhmpxwxTK3iIU5gGY4RHYCOg2OWMZSTYPm0QsqQ/K/SQuzk+g5Q+9Xr/dcjgg52W8xNLzdh4MPPMoGiSlnRts=
X-Received: by 2002:a05:6402:348c:b0:640:cdad:d2c0 with SMTP id
 4fb4d7f45d1cf-64538227a06mr2493204a12.25.1763647727793; Thu, 20 Nov 2025
 06:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
In-Reply-To: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 20 Nov 2025 08:08:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2sFzQb8j5bBWbwgyYn5apLTfWOTZW3+9n74uVyph16A@mail.gmail.com>
X-Gm-Features: AWmQ_bl_e2mY7mehKL9PPzNTQx6rMW289JXHIko6uxRTQ1xj75fDik3Oj__esgs
Message-ID: <CAL_Jsq+2sFzQb8j5bBWbwgyYn5apLTfWOTZW3+9n74uVyph16A@mail.gmail.com>
Subject: Re: [PATCH RFC] of: Add of_parse_map_iter() helper for nexus node map iteration
To: "Kevin Hilman (TI.com)" <khilman@baylibre.com>, Herve Codina <herve.codina@bootlin.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Herve

On Wed, Nov 19, 2025 at 6:41=E2=80=AFPM Kevin Hilman (TI.com)
<khilman@baylibre.com> wrote:
>
> Add a new helper function of_parse_map_iter() to iterate over nexus
> node maps (c.f. DT spec, section 2.5.1.)
>
> This function provides an iterator interface for traversing map
> entries, handling the complexity of variable-sized entries based on
> <stem>-cells properties, as well as handling the <stem>-skip and
> <stem>-pass-thru properties.
>
> RFC: There's a lot of overlap between this function and
> of_parse_phandle_with_args_map().  However the key differences are:
>
>   - of_parse_phandle_with_args_map() does matching
>     it searches for an entry that matches specific child args
>   - of_parse_map_iter() does iteration
>     it simply walks through all entries sequentially

There's also this in flight for interrupt-map:

https://lore.kernel.org/all/20251027123601.77216-2-herve.codina@bootlin.com=
/

There's probably enough quirks with interrupt-map that we can't use
the same code. Though it may boil down to handling #address-cells and
how the parent is looked up.

> There are likely ways to extract some shared code between these two
> functions into some shared helpers, but I'm hoping someone more
> familiar with this OF code can help here.

I would expect of_parse_phandle_with_args_map() could be implemented
in terms of the iterator.

> However, before refactoring the shared code, it would be good to have
> some feedback on this approach.
>
> Signed-off-by: Kevin Hilman (TI.com) <khilman@baylibre.com>
> ---
>  drivers/of/base.c  | 167 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  include/linux/of.h |  13 ++++
>  2 files changed, 180 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 7043acd971a0..bdb4fde1bfa9 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1594,6 +1594,173 @@ int of_parse_phandle_with_args_map(const struct d=
evice_node *np,
>  }
>  EXPORT_SYMBOL(of_parse_phandle_with_args_map);
>
> +/**
> + * of_parse_map_iter() - Iterate through entries in a nexus node map
> + * @np:                        pointer to a device tree node containing =
the map
> + * @stem_name:         stem of property names (e.g., "power-domain" for =
"power-domain-map")
> + * @index:             pointer to iteration index (set to 0 for first ca=
ll)
> + * @child_args:                pointer to structure to fill with child s=
pecifier (can be NULL)
> + * @parent_args:       pointer to structure to fill with parent phandle =
and specifier
> + *
> + * This function iterates through a nexus node map property as defined i=
n DT spec 2.5.1.
> + * Each map entry has the format: <child_specifier phandle parent_specif=
ier>
> + *
> + * On each call, it extracts one map entry and fills child_args (if prov=
ided) with the
> + * child specifier and parent_args with the parent phandle and specifier=
.
> + * The index pointer is updated to point to the next entry for the follo=
wing call.
> + *
> + * Example usage::
> + *
> + *  int index =3D 0;
> + *  struct of_phandle_args child_args, parent_args;
> + *
> + *  while (!of_parse_map_iter(np, "power-domain", &index, &child_args, &=
parent_args)) {
> + *      // Process child_args and parent_args
> + *      of_node_put(parent_args.np);
> + *  }
> + *
> + * Caller is responsible for calling of_node_put() on parent_args.np.
> + *
> + * Return: 0 on success, -ENOENT when iteration is complete, or negative=
 error code on failure.
> + */
> +int of_parse_map_iter(const struct device_node *np,
> +                      const char *stem_name,
> +                      int *index,
> +                      struct of_phandle_args *child_args,
> +                      struct of_phandle_args *parent_args)
> +{
> +       char *cells_name __free(kfree) =3D kasprintf(GFP_KERNEL, "#%s-cel=
ls", stem_name);
> +       char *map_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map", =
stem_name);
> +       char *mask_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-m=
ask", stem_name);
> +       char *pass_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-p=
ass-thru", stem_name);
> +       static const __be32 dummy_mask[] =3D { [0 ... MAX_PHANDLE_ARGS] =
=3D cpu_to_be32(~0) };
> +       static const __be32 dummy_pass[] =3D { [0 ... MAX_PHANDLE_ARGS] =
=3D cpu_to_be32(0) };
> +       const __be32 *map, *mask, *pass;
> +       __be32 child_spec[MAX_PHANDLE_ARGS];
> +       u32 child_cells, parent_cells;
> +       int map_len, i, entry_idx;
> +
> +       if (!np || !stem_name || !index || !parent_args)
> +               return -EINVAL;
> +
> +       if (!cells_name || !map_name || !mask_name || !pass_name)
> +               return -ENOMEM;
> +
> +       /* Get the map property */
> +       map =3D of_get_property(np, map_name, &map_len);
> +       if (!map)
> +               return -ENOENT;
> +
> +       map_len /=3D sizeof(u32);
> +
> +       /* Get child #cells */
> +       if (of_property_read_u32(np, cells_name, &child_cells))
> +               return -EINVAL;
> +
> +       /* Get the mask property (optional) */
> +       mask =3D of_get_property(np, mask_name, NULL);
> +       if (!mask)
> +               mask =3D dummy_mask;
> +
> +       /* Get the pass-thru property (optional) */
> +       pass =3D of_get_property(np, pass_name, NULL);
> +       if (!pass)
> +               pass =3D dummy_pass;

Generally the DT iterators need some state maintained, so there's an
init function to do all/most of the above and stash that into a state
struct for the iterator.

> +
> +       /* Iterate through map to find the entry at the requested index *=
/
> +       entry_idx =3D 0;
> +       while (map_len > child_cells + 1) {
> +               /* If this is the entry we're looking for, extract it */
> +               if (entry_idx =3D=3D *index) {
> +                       /* Save masked child specifier for pass-thru proc=
essing */
> +                       for (i =3D 0; i < child_cells && i < MAX_PHANDLE_=
ARGS; i++)
> +                               child_spec[i] =3D map[i] & mask[i];
> +
> +                       /* Extract child specifier if requested */
> +                       if (child_args) {
> +                               child_args->np =3D (struct device_node *)=
np;
> +                               child_args->args_count =3D child_cells;
> +                               for (i =3D 0; i < child_cells && i < MAX_=
PHANDLE_ARGS; i++)
> +                                       child_args->args[i] =3D be32_to_c=
pu(map[i]);
> +                       }
> +
> +                       /* Move past child specifier */
> +                       map +=3D child_cells;
> +                       map_len -=3D child_cells;
> +
> +                       /* Extract parent phandle */
> +                       parent_args->np =3D of_find_node_by_phandle(be32_=
to_cpup(map));

Before you update the parent node, you need to put the previous parent.

> +                       map++;
> +                       map_len--;
> +
> +                       if (!parent_args->np)
> +                               return -EINVAL;
> +
> +                       /* Get parent #cells */
> +                       if (of_property_read_u32(parent_args->np, cells_n=
ame, &parent_cells))
> +                               parent_cells =3D 0;
> +
> +                       /* Check for malformed properties */
> +                       if (WARN_ON(parent_cells > MAX_PHANDLE_ARGS) ||
> +                           map_len < parent_cells) {
> +                               of_node_put(parent_args->np);
> +                               return -EINVAL;
> +                       }
> +
> +                       /*
> +                        * Copy parent specifier into the out_args struct=
ure, keeping
> +                        * the bits specified in <stem>-map-pass-thru per=
 DT spec 2.5.1
> +                        */
> +                       parent_args->args_count =3D parent_cells;
> +                       for (i =3D 0; i < parent_cells; i++) {
> +                               __be32 val =3D map[i];
> +
> +                               if (i < child_cells) {
> +                                       val &=3D ~pass[i];
> +                                       val |=3D child_spec[i] & pass[i];
> +                               }
> +
> +                               parent_args->args[i] =3D be32_to_cpu(val)=
;
> +                       }
> +
> +                       /* Advance index for next iteration */
> +                       (*index)++;
> +                       return 0;
> +               }
> +
> +               /* Skip this entry: child_cells + phandle + parent_cells =
*/
> +               map +=3D child_cells;
> +               map_len -=3D child_cells;
> +
> +               /* Get parent node to determine parent_cells */
> +               parent_args->np =3D of_find_node_by_phandle(be32_to_cpup(=
map));
> +               map++;
> +               map_len--;
> +
> +               if (!parent_args->np)
> +                       return -EINVAL;
> +
> +               if (of_property_read_u32(parent_args->np, cells_name, &pa=
rent_cells))
> +                       parent_cells =3D 0;
> +
> +               of_node_put(parent_args->np);
> +
> +               /* Check for malformed properties */
> +               if (map_len < parent_cells)
> +                       return -EINVAL;
> +
> +               /* Move forward by parent node's #<stem>-cells amount */
> +               map +=3D parent_cells;
> +               map_len -=3D parent_cells;
> +
> +               entry_idx++;
> +       }
> +
> +       /* Reached end of map without finding the requested index */
> +       return -ENOENT;
> +}
> +EXPORT_SYMBOL(of_parse_map_iter);
> +
>  /**
>   * of_count_phandle_with_args() - Find the number of phandles references=
 in a property
>   * @np:                pointer to a device tree node containing a list

